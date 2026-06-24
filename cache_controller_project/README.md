
# Direct-Mapped Write-Back Cache Controller

## Project Overview
This project implements a Direct-Mapped Write-Back Cache Controller in Verilog HDL.
The design supports cache hits, cache misses, write-hit operations, dirty-bit tracking,
write-back policy, and write-allocate behavior.

## Cache Organization
- Cache Type: Direct Mapped
- Address Width: 8-bit
- Tag: 4 bits
- Index: 2 bits
- Offset: 2 bits
- Cache Lines: 4
- Block Size: 4 words (128 bits)

## Address Format
| Tag | Index | Offset |
|------|------|------|
| 4 bits | 2 bits | 2 bits |

## FSM States
- IDLE
- COMPARE_TAG
- WRITE_HIT
- MISS
- WRITE_BACK
- ALLOCATE
- DONE

## RTL Modules
- cache_controller.v
- cache_lookup.v
- cache_top.v
- tag_array.v
- data_array.v
- dirty_array.v
- main_memory.v
- cache_stats.v

## Features
- Cache Hit Detection
- Cache Miss Handling
- Dirty Bit Tracking
- Write Back Policy
- Write Allocate Policy
- Main Memory Interface
- Verification Testbenches

## Verification
Verified using Icarus Verilog and GTKWave with:
- Cold Miss Test
- Cache Hit Test
- Write Hit Test
- Dirty Miss Test
- Write Back Test

