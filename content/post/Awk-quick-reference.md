---
title: "AWK: the text data processing chainsaw"
date: 2021-10-10T17:00:00-06:00
draft: true
---
## Overview
This tutorial is written from the spective of processing lots of text data in a very quick fashion some ways that you could use this tool would be to parse log files or command output. I have used AWK to quicly parse and summarize logs that contain very small numbers of records to thousands of records. The great thing about awk is that it is included out of the box in most Unix based operating systems such as Linux, GNU, and Mac OSX.

### Required Technologies
1. Unix based operating system such as Linux, GNU, or even Mac OSX.
2. Shell such as BASH, ZSH, etc.
3. VIM, or your favorite programmers text editor.

### Steps
1. ensure that AWK is installed on your operating system.
```zsh
awk --version
```
If you have awk installed in your terminal it should pull back something like:
```zsh
awk version 20200816
```


## References

[Homebrew Website](https://brew.sh/ "Homebrew Website")

[GNU Awk Users Guide](https://www.gnu.org/software/gawk/manual/gawk.html#Regexp "GNU Awk Users Guide")
