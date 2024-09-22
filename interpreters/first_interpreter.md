# SCANNING - LEXING

The first step in any compiler or interpreter is scanning. The scanner takes in raw source code as a series of characters and groups it into a series of chunks we call _TOKENS_. These are the meaningful "words" and "punctuation" that make up the language's grammar.

Historically **SCANNER** only refer to the piece of code that dealt with reading new source code characters from disk and buffering them in memory. Then **LEXING** was the subsequent phase that did useful stuff with the characters.
