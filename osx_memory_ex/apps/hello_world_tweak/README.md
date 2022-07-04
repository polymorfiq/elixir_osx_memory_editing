# Tweak: Hello World

Finds a running instance of `toy_programs/hello_world`, attaches to the process, does a couple sanity checks and then modifies the text that is being printed.

It does so by writing to an offset into the the application's memory where the string is stored. This offset was found utilizing the [Bit Slicer](https://github.com/zorgiepoo/Bit-Slicer) Mac application.

This was tested on an M1 Mac with SIP disabled. If you have any questions, consult the root README.md file.


## Usage

- In this directory, (assuming Elixir is installed), run `mix deps.get` and `mix compile` to download the dependencies and ensure compilation of the program is working.

- Start out by running the application stored in `toy_programs/hello_world` within another terminal window

-  Then run `sudo mix run` in the original terminal window. `sudo` is needed due to Mac process memory protections.

If all goes well, the Hello World application will have its text modified.

Play around with the app, what it can say - see what you can do!
