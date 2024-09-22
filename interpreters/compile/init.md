# Compiling Explained

Computers don't know how to do anything unless we as programmers tell them what to do

Unfortunately, computers don't understand human language. They don't even understand uncompiled computer programs.

## Computers Need Machine Code

A computer's CPU only understands its own instruction set, which we call "machine code".

Instructions are basic math operations like addition, subtraction, multiplication, and the ability to save data temporarily.

For example, an ARM processor uses the ADD instruction when supplied with the number 0100 in binary

## Go, C, Rust, ETC.

Are all languages where the code is first converted to machine code by the compiler before its executed

```text
|---------|               |---------|
| Source  |               | Source  |
|  File   |               | File    |
|_________|               |_________|
     |                        |
     v                        v
|---------|               |---------|
| Object  |               | Object  |
|  File   |               |  File   |
|_________|               |_________|
    |                           |
    -------------->| |<----------
                   v v
|---------|   |---------|   |---------|
| Runtime |   |         |   |         |
|  Lib    |-> | Linker  |<- | Linker  |
|_________|   |_________|   |_________|
```

## COMPILED VS INTERPRETED

You can run a compiled program without the original source code. You don't even need a compiler. For example, when your browser executes the code you write in this course, it doesn't use the original code, just the compiled executable.

This is different than interpreted languages like Python and JavaScript. With Python and JavaScript, the code is interpreted at runtime by a separate program known as the "interpreter". Distributing code for users to run can be a pain because they need to have an interpreter installed, and they need access to the source code.

**EXAMPLES OF COMPILED LANGUAGES**

- Go
- C
- C++
- Rust
  **EXAMPLES OF INTERPRETED LANGUAGES**

- JavaScript
- Python
- Ruby

## BYTE

The byte is a unit of digital information that most commonly consists of eight bits. Historically, the byte was the number of bits used to encode a single character of text in a computer[1][2] and for this reason it is the smallest addressable unit of memory in many computer architectures. To disambiguate arbitrarily sized bytes from the common 8-bit definition, network protocol documents such as the Internet Protocol (RFC 791) refer to an 8-bit byte as an octet.[3] Those bits in an octet are usually counted with numbering from 0 to 7 or 7 to 0 depending on the bit endianness.

The size of the byte has historically been hardware-dependent and no definitive standards existed that mandated the size. Sizes from 1 to 48 bits have been used.[4][5][6][7] The six-bit character code was an often-used implementation in early encoding systems, and computers using six-bit and nine-bit bytes were common in the 1960s. These systems often had memory words of 12, 18, 24, 30, 36, 48, or 60 bits, corresponding to 2, 3, 4, 5, 6, 8, or 10 six-bit bytes. In this era, bit groupings in the instruction stream were often referred to as syllables[a] or slab, before the term byte became common.

The modern de facto standard of eight bits, as documented in ISO/IEC 2382-1:1993, is a convenient power of two permitting the binary-encoded values 0 through 255 for one byte, as 2 to the power of 8 is 256.[8] The international standard IEC 80000-13 codified this common meaning. Many types of applications use information representable in eight or fewer bits and processor designers commonly optimize for this usage. The popularity of major commercial computing architectures has aided in the ubiquitous acceptance of the 8-bit byte.[9] Modern architectures typically use 32- or 64-bit words, built of four or eight bytes, respectively.
