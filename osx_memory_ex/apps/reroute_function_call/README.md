# Tweak: Hello World

Finds a running instance of `toy_programs/function_caller`, attaches to the process, does a couple sanity checks and then modifies a function call in main() (that points to `do_nothing()`) to instead route to `print_message()` (another function in the program)

It does so by writing to an offset into the the application's memory where the assembly instructions (a `bl` instruction, in particular) is stored. This offset was found utilizing the [Bit Slicer](https://github.com/zorgiepoo/Bit-Slicer) and [Hopper Disassembler](https://www.hopperapp.com/) Mac applications.

This was tested on an M1 Mac with SIP disabled. If you have any questions, consult the root README.md file.

## Usage

- In this directory, (assuming Elixir is installed), run `mix deps.get` and `mix compile` to download the dependencies and ensure compilation of the program is working.

- Start out by running the application stored in `toy_programs/function_Caller` within another terminal window

-  Then run `sudo mix run` in the original terminal window. `sudo` is needed due to Mac process memory protections.

If all goes well, the application will go from doing nothing, to printing "My function call has been rerouted!" every few seconds.

Play around with the app, what it can say - see what you can do!
