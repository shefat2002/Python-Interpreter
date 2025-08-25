# Python-Interpreter (8086 Assembly)

An educational, Python-like mini interpreter written in 16-bit x86 assembly for DOS. It provides a tiny REPL with:
- Single-character variables: a, b, c, d, e
- Single-digit arithmetic: +, -, *, /
- Basic printing: strings and variables
- Simple commands: help, version, clear, show variables, exit

This project is intended for learning 8086 assembly, DOS interrupts (INT 21h/INT 10h), and simple interpreter design.

## Features

- Interactive prompt: `>>> `
- Print:
  - Strings: `print("Hello")`
  - Variables: `print(a)`
- Variables: `a`, `b`, `c`, `d`, `e` (each stores a single ASCII digit)
- Arithmetic with single digits: `+`, `-`, `*`, `/`
- Commands:
  - `h` — help
  - `v` — version
  - `q` — clear screen
  - `s` — show variables
  - `x` — exit

## Requirements

- emu8086 (recommended, easiest way to assemble and run)

## Setup and Run (emu8086)

1. Install emu8086 (search for “emu8086” and install the latest stable version).
2. Open emu8086.
3. File → Open → select `code.asm` (or create a new file and paste the contents).
4. Click “Assemble” to build.
5. Click “Emulate” (Run). You should see the REPL prompt `>>> `.

No external toolchains or DOSBox are required when using emu8086.

## Usage

At the `>>>` prompt, type one of the following and press Enter:

- Print a string
  - `print("Hello World")`

- Print a variable
  - `print(a)`

- Assign and compute (single-digit operands)
  - `a=3+4`
  - `b=9-5`
  - `c=6*3`
  - `d=8/2`

- Commands
  - `h` — show help
  - `v` — show version
  - `q` — clear screen
  - `s` — show current values of `a`..`e`
  - `x` — exit

Tip: Variables store a single ASCII digit character. Arithmetic is evaluated left-to-right with single-digit operands.

## Notes and Limitations

- Designed for 16-bit DOS (tested in emu8086).
- Variables `a`..`e` hold one character ('0'..'9').
- Arithmetic operates on single digits; multi-digit numbers are not supported.

## Repository Structure

- `code.asm` — source code (8086 assembly)
- `README.md` — this document

## Author

- GitHub: https://github.com/shefat2002
