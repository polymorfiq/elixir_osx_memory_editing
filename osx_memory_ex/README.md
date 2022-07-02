# OsxMemoryEx

In order for any of these examples to work, you might need to disable SIP on your Mac and then re-enable via `csrutil enable --without debug --without dtrace` (to enable SOME protection while you try things out)

**How to disable SIP:**
https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection


# Examples

## toy_apps/hello_world

Runs together with `osx_memory_ex/apps/hello_world_tweak` 

The toy app prints a static message, every 5 seconds.

The Elixir application will essentially **overwrite** the string "Hello, world!" with "Hi, world!" in the running program by overwriting the TEXT section in the program's memory.