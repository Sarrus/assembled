# assembled

A very simple application for printing the Fibonacci Sequence written in x86 assembly using NASM syntax.

The tricky part is not generating the sequence but in converting it to decimal for display on the screen.

## Building

You will need CMake and NASM. Currently, this will only run on MacOS.

Prepare the build files:

    $ cd /path/to/source
    $ cmake ./

Run the build:

    $ cmake --build ./

## Running

    $ ./fibonacci

Should output the Fibonacci Sequence up to position 48.
