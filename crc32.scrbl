#lang scribble/manual
@(require scribble/examples)
@require[@for-label[crc32
                    racket/base]]

@title{CRC32}
@author{Ji Ren}

@defmodule[crc32]

This package provides CRC32 (IEEE 802.3 standard) checksum computation functions.

CRC32 is commonly used for error detection in network transmissions and file integrity checks.

@section{API Reference}

@defproc[(crc32-bytes [bs bytes?]) exact-nonnegative-integer?]{
  Computes the CRC32 checksum of the given byte string.
  
  @examples[#:eval (make-base-eval)
    (require crc32)
    (crc32-bytes #"abc")
    (number->string (crc32-bytes #"abc") 16)
  ]
}

@defproc[(crc32-string/utf8 [str string?]) exact-nonnegative-integer?]{
  Computes the CRC32 checksum of the UTF-8 encoding of the given string.
  
  @examples[#:eval (make-base-eval)
    (require crc32)
    (crc32-string/utf8 "hello")
    (number->string (crc32-string/utf8 "hello") 16)
  ]
}

@defproc[(crc32-string/latin-1 [str string?]) exact-nonnegative-integer?]{
  Computes the CRC32 checksum of the Latin-1 encoding of the given string.
}

@defproc[(crc32-string/locale [str string?]) exact-nonnegative-integer?]{
  Computes the CRC32 checksum of the locale encoding of the given string.
}

@defproc[(crc32-input-port [in input-port? (current-input-port)]) exact-nonnegative-integer?]{
  Computes the CRC32 checksum of all bytes read from the input port.
  
  @examples[#:eval (make-base-eval)
    (require crc32)
    (crc32-input-port (open-input-bytes #"test data"))
  ]
}

@section{Low-level API}

For incremental computation or when you need more control over the process:

@defthing[crc32-initial-value exact-nonnegative-integer?]{
  The initial value for CRC32 computation (@racket[#xFFFFFFFF]).
}

@defproc[(crc32-update [acc exact-nonnegative-integer?] [byte exact-nonnegative-integer?]) exact-nonnegative-integer?]{
  Updates the CRC32 accumulator with a single byte.
}

@defproc[(crc32-finalize [acc exact-nonnegative-integer?]) exact-nonnegative-integer?]{
  Finalizes the CRC32 computation by applying the final XOR.
}

@section{Examples}

@examples[#:eval (make-base-eval)
  (require crc32)
  
  ; Basic usage
  (crc32-bytes #"hello world")
  
  ; Incremental computation
  (define acc crc32-initial-value)
  (set! acc (crc32-update acc 104)) ; 'h'
  (set! acc (crc32-update acc 101)) ; 'e'
  (set! acc (crc32-update acc 108)) ; 'l'
  (set! acc (crc32-update acc 108)) ; 'l'
  (set! acc (crc32-update acc 111)) ; 'o'
  (crc32-finalize acc)
  
  ; Same result as:
  (crc32-bytes #"hello")
]