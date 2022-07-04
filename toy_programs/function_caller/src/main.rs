use std::{thread, time};

fn main() {
    let mut always_false = false;

    loop {
        do_nothing(&mut always_false);

        // This is just so Rust doesn't optimize out the function body.
        if always_false {
            print_message();
        }

        thread::sleep(time::Duration::from_secs(5));
    }
}

fn print_message() {
    println!("My function call has been rerouted!");
}

fn do_nothing(always_false: &mut bool) {
    // NOOP
}