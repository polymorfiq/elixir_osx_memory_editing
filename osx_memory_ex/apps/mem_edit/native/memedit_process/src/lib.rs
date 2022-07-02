#![allow(dead_code)]

use sysinfo::{ProcessExt, PidExt, System, SystemExt};
use vmemory::*;

mod memory_darwin;

#[rustler::nif]
fn get_processes() -> Vec<(u32, String)> {
    let s = System::new_all();
    let mut processes = Vec::new();
    for (pid, process) in s.processes() {
        processes.push((pid.as_u32(), process.name().to_string()));
    }

    return processes;
}

#[rustler::nif]
fn get_base_address(pid: u32) -> (bool, usize) {
    let handle = ProcessMemory::attach_process(pid);

    match handle {
        Some(handle) => {
            return (true, handle.base());
        }

        None => {
            return (false, 0);
        }
    }
}

#[rustler::nif]
fn read_memory(pid: u32, addr: usize, size: usize) -> (bool, Vec<u8>) {
    let handle = ProcessMemory::attach_process(pid);

    match handle {
        Some(handle) => {
            let data = handle.read_memory(addr, size, false);
            return (true, data)
        }

        None => {
            return (false, vec![]);
        }
    }
}

#[rustler::nif]
fn write_memory(pid: u32, addr: usize, data: Vec<u8>) -> (bool, String) {
    let task = memory_darwin::get_task_for_pid(pid);
    match memory_darwin::write_memory(task, addr, &data) {
        Ok(_) => (true, "".to_string()),
        Err(e) => (false, e.to_string())
    }
}

rustler::init!("Elixir.MemEdit.Process", [get_processes, read_memory, write_memory, get_base_address]);
