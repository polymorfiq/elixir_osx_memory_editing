# OSX Memory Editing: Elixir + Rust edition!

This project has a collection of Rust toy applications that do a simple thing, and Elixir + Rust (via rustler) apps, that tweak that functionality by injecting into the running program and writing to its memory.

Elixir apps can be found in `osx_memory_ex/apps` and Rust toy apps can be found in `toy_programs/` - each toy program has corresponding Elixir applications that modify it

This repository mainly serves as a reference - a starting point from which to jump into the world of Memory Editing MacOS applications.

It can be a fun way to see a collaboration between Rust and Elixir!

## Notes

In order for any of these examples to work, you might need to disable SIP on your Mac and then re-enable via `csrutil enable --without debug --without dtrace` (to enable SOME protection while you try things out)

**How to disable SIP:**
https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection

### Toy Programs: hello_world

Runs together with `osx_memory_ex/apps/hello_world_tweak` 

The toy app prints a static message, every 5 seconds.

The Elixir application will essentially **overwrite** the string "Hello, world!" with "Hi, world!" in the running program by overwriting the TEXT section in the program's memory.
