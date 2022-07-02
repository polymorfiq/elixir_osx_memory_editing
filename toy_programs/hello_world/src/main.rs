use std::{thread, time};

// These are simply here in case you want to edit any of them by tweaking the example memory injectors!
const X: u8 = 0b11111111;
const Y: u8 = 0b10111111;
const Z: u8 = 0b11111111;
const A: u8 = 0b11111111;
const PIE: &str = "Boom!!!";

fn main() {
    loop {
        println!("Hello, world! {} {} {} {} {}", X, Y, Z, A, PIE);
        let sleep_dur = time::Duration::from_secs(5);
        thread::sleep(sleep_dur);
    }
}
