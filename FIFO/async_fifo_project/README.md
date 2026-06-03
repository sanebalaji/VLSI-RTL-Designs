# Asynchronous FIFO (Dual Clock FIFO)

## Overview
Implemented an Asynchronous FIFO in Verilog HDL for safe data transfer between two independent clock domains.

## Features
- Binary write/read pointers
- Gray code conversion
- Pointer synchronization using 2-FF synchronizers
- Full detection logic
- Empty detection logic
- Independent write and read clocks

## Verification
- Unit testbenches for individual modules
- Top-level Async FIFO testbench
- Verified using GTKWave

## Files
- async_fifo.v
- fifo_mem.v
- gray_converter.v
- synchronizer.v
- write_pointer.v
- read_pointer.v
- full_logic.v
- empty_logic.v