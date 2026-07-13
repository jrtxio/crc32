# CRC32

CRC32 (IEEE 802.3) checksum implementation for Racket. Computes CRC32 checksums for byte strings, strings in various encodings, and input ports, with a low-level API for incremental computation.

![Racket](https://img.shields.io/badge/Racket-9F1D20?logo=racket&logoColor=white) [![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

**English** · [中文](README.zh-CN.md)

## Installation

```bash
raco pkg install crc32
```

## Usage

```racket
#lang racket
(require crc32)

; Compute CRC32 of a byte string
(crc32-bytes #"hello world")

; Compute CRC32 of a UTF-8 encoded string
(crc32-string/utf8 "hello world")

; Compute CRC32 from an input port
(crc32-input-port (open-input-file "myfile.txt"))
```

## API

### High-level API

| Function | Description |
|----------|-------------|
| `(crc32-bytes bs)` | Compute CRC32 of a byte string |
| `(crc32-string/utf8 str)` | Compute CRC32 of a UTF-8 encoded string |
| `(crc32-string/latin-1 str)` | Compute CRC32 of a Latin-1 encoded string |
| `(crc32-string/locale str)` | Compute CRC32 of a locale-encoded string |
| `(crc32-input-port [in])` | Compute CRC32 from an input port |

All functions return an `exact-nonnegative-integer?`.

### Low-level API (Incremental Computation)

```racket
; Incremental computation
(define acc crc32-initial-value)
(set! acc (crc32-update acc 104)) ; 'h'
(set! acc (crc32-update acc 101)) ; 'e'
(set! acc (crc32-update acc 108)) ; 'l'
(set! acc (crc32-update acc 108)) ; 'l'
(set! acc (crc32-update acc 111)) ; 'o'
(crc32-finalize acc)
; => same as (crc32-bytes #"hello")
```

| Function / Value | Description |
|------------------|-------------|
| `crc32-initial-value` | Initial CRC32 accumulator value (`#xFFFFFFFF`) |
| `(crc32-update acc byte)` | Update accumulator with a single byte |
| `(crc32-finalize acc)` | Apply final XOR to produce the checksum |

## Development

```bash
raco test main.rkt
```

The test suite covers standard test vectors, boundary cases, repeated patterns, incremental sequences, ASCII strings, UTF-8 strings (including CJK, emoji, Cyrillic, Arabic, and Greek), large data, binary file format headers, incremental computation, and input port functionality.

## Requirements

- Racket 7.0 or later

## License

Released under the [MIT License](LICENSE).
