# CRC32

A Racket package providing CRC32 (IEEE 802.3 standard) checksum computation.

## Installation

```bash
raco pkg install crc32
```

## Usage

```racket
#lang racket
(require crc32)

; Compute CRC32 of byte string
(crc32-bytes #"hello world")

; Compute CRC32 of UTF-8 string  
(crc32-string/utf8 "hello world")

; Compute CRC32 from input port
(crc32-input-port (open-input-file "myfile.txt"))
```

## API

- `crc32-bytes` - Compute CRC32 of byte string
- `crc32-string/utf8` - Compute CRC32 of UTF-8 encoded string
- `crc32-string/latin-1` - Compute CRC32 of Latin-1 encoded string  
- `crc32-string/locale` - Compute CRC32 of locale encoded string
- `crc32-input-port` - Compute CRC32 from input port

For incremental computation:
- `crc32-initial-value` - Initial CRC32 value
- `crc32-update` - Update CRC32 with single byte
- `crc32-finalize` - Finalize CRC32 computation

## Testing

```bash
raco test crc32.rkt
```

## License

MIT