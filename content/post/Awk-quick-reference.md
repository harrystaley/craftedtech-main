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

### Initial setup
Ensure that AWK is installed on your operating system.
```zsh
awk --version
```
If you have awk installed in your terminal it should pull back something like:
```zsh
awk version 20200816
```
If you do not have awk installed or you get an error install it using your favorite package manager as seen below:

Mac OSX Homebrew:
```bash
brew install awk
```
Debian based GNU/Linux using Advance Package Tool (APT):
```
sudo apt-get update
sudo apt-get install gawk
```
RPM based GNU/Linux, use Yellowdog Updator Modifier [yum]:
```
yum install gawk
```
Check where awk is installed and that it is accessible to your terminal:
```
which awk
```
You should see something simmilar to the below as a result of the above command:
```
/usr/bin/awk
```
Remember where this was installed because we are going to use this later when we create our awk file.

## Anatomy of Awk and it's workflow.

The general workflow of awk is to "Until EOF Read, Execute, Repeat".

That being said there are three blocks that make up Awk with two blocks being optional as seen in the table below.

|Optional/Required|Block|Execution|
|--------|-----------|---------|
|Optional|BEGIN {Awk do stuff}|Executed once|
|Required|/pattern/ {Awk do stuff}|Executed on each line until End of File (EOF)|
|Optional|END {Awk Awk do stuff}|executed once|



## References

[Homebrew Website](https://brew.sh/ "Homebrew Website")

[GNU Awk Users Guide](https://www.gnu.org/software/gawk/manual/gawk.html#Regexp "GNU Awk Users Guide")
