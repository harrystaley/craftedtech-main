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
```bash
awk --version
```
If you have awk installed in your terminal it should pull back something like:
```bash
awk version 20200816
```
If you do not have awk installed or you get an error install it using your favorite package manager as seen below:

Mac OSX Homebrew:
```bash
brew install awk
```
Debian based GNU/Linux using Advance Package Tool (APT):
```bash
sudo apt-get update
sudo apt-get install gawk
```

RPM based GNU/Linux, use Yellowdog Updator Modifier [yum]:
```bash
yum install gawk
```
Check where Awk is installed and that it is accessible to your terminal:
Input:
```bash
which awk
```
Output:
```bash
/usr/bin/awk
```
Remember where this was installed because we are going to use this later when we create our awk file.

## Anatomy of a chainsaw: Awk and it's workflow.

The general workflow of awk is to "Until End Of File Read, Execute, Repeat".
Thus AWK reads a line from the input stream (file, pipe, or stdin), stores it in memory and then executes commands on that line. 
This process of reading and execution continues until the end of the input stream a.k.a EOF. Once completed Awk sends the results to the output stream (file, pipe, or stdout). 

Here is an example of how to run Awk on myfile.txt
```bash
awk 'Begin-Body-End-blocks' myfile.txt
```
As such Begin-Body-End-blocks will be executed on each line of myfile.txt

That being said there are three code blocks that make up Awk with two of which are optional as seen in the table below.

|Block Name|Optional/Required|Syntax|Execution|
|---------|--------|-----------|---------|
|Begin|Optional|BEGIN {Awk do stuff}|Executed at the beginning of the program once|
|Body|Optional|/pattern/ {Awk do stuff}|Executed on each line until End of File (EOF)|
|End|Optional|END {Awk Awk do stuff}|Executed at the end of the program once|

Having learned all of that lets kick the tires a bit in the next section.

## Syntax
AWK can be executed directly from the terminal or form of a text file containing AWK commands.

### Terminal Execution
Awk can be executed from the terminal directly isng the below example.
```bash
awk [options] 'Begin-Body-End-blocks' target_input_stream ...
```
1. Create a file titled 'myfile.txt' using the touch command as seen below.
Input:
```bash
touch myfile.txt
```
Output:
A file named myfile.txt is created in the cureent directory.
2. Now lets open myfile.txt in our favorite text editor such as VIM and copy the following text into the file saving it.
```bash
Line 1
Line 2
Line 3
Line 4
```
3. Lets execute our first awk command on our file.
Input:
```bash
awk 'BEGIN{printf "---Begin Block---"} {print} END{printf "---End Block---"}' myfile.txt
```
Output:
```bash
---Begin Block---
Line 1
Line 2
Line 3
Line 4
---End Block---
```
As you can see from our example the Begin block (BEGIN{printf "---Begin Block---"}) executes, the Body block executes ({print}) printing each line in the file, and finally the End block executes (END{printf "---End Block---"}).

### Text File Execution
In order to use a text file we replace ```'Begin-Body-End-blocks'``` with ```-f scrpt_file``` such as below.
```bash
awk [options] -f scrpt_file target_input_stream ...
```
To test this let's expand on what we have created for the terminal example a bit. 

1. Create a file titled 'scriptfile.awk' using the touch command as seen below.
Input:
```bash
touch scriptfile.awk
```
Output:
A file named scriptfile.awk is created in the current directory.

2. Now lets open scriptfile.awk in our favorite text editor such as VIM and copy the following text into the file saving it.
```bash
BEGIN{
  printf "---Begin Block---"
}
{
  print
}
END{
  printf "---End Block---"
}
```
3. Lets execute our first awk command on our file.
Input:
```bash
awk -f scriptfile.awk myfile.txt
```
Output:
```bash
---Begin Block---
Line 1
Line 2
Line 3
Line 4
---End Block---
```
### Options
Awk comes with options that can be very helpful in our text mining journey here are just a few. To get a full list of options reference the man page for Awk or check out the references at the bottom of this blog post.

#### -v

The -v option assigns a value to a variable. It assigns varialbe values before program execution.

Input:
```bash
awk -v fname=Harry 'BEGIN{printf "Good morning %s!\n", fname}'
```
Output:
```bash
Good morning Harry!
```
If you notice this still works because no matter what the Begin block is always executed at the beginning of hte program regardless of the existance of the other blocks.

## Built-In Variables
Awk provides several convenient built-in variables that make things very convenient for us to use.

### ARGC

ARGC stores a count of the number of arguments provided at the terminal.
Input:
```bash
awk 'BEGIN {print "Argument Count =", ARGC}' arg1 arg2 arg3 arg4
```
Output:
```bash
Argument Count = 5
```
As you can see the argument count shows 5 because awk counts as the first argument.

### ARGV
ARGV is a one dimensional array that stores the arguments passed into Awk with valid inddexes rangeing from 0 to ARGC-1.

Input:
```bash
awk 'BEGIN { 
   for (i = 0; i < ARGC; i++) { 
      printf "ARGV[%d] = %s\n", i, ARGV[i] 
   } 
}' arg1 arg2 arg3 arg4
```
Output:
```bash
ARGV[0] = awk
ARGV[1] = arg1
ARGV[2] = arg2
ARGV[3] = arg3
ARGV[4] = arg4
 ```
### CONVFMT

CONVFMT stores the conversion format for numbers. By default its' value is %.6g.

Input:
```
awk 'BEGIN { print "Number Conversion Format =", CONVFMT }'
```
Output:
```
Number Conversion Format = %.6g
```
### ENVIRON
ENVIRON is an associative array for environmental variables.
Input:
```
awk 'BEGIN { print ENVIRON["USER"] }'
```
Output:
```
someuser
```
To find other environment variables, use ```env``` command or see the references section at the bottom of this article.


FILENAME

It represents the current file name.

Example

[jerry]$ awk 'END {print FILENAME}' marks.txt

On executing this code, you get the following result −

Output

marks.txt

Please note that FILENAME is undefined in the BEGIN block.
FS

It represents the (input) field separator and its default value is space. You can also change this by using -F command line option.

Example

[jerry]$ awk 'BEGIN {print "FS = " FS}' | cat -vte

On executing this code, you get the following result −

Output

FS =  $

NF

It represents the number of fields in the current record. For instance, the following example prints only those lines that contain more than two fields.

Example

[jerry]$ echo -e "One Two\nOne Two Three\nOne Two Three Four" | awk 'NF > 2'

On executing this code, you get the following result −

Output

One Two Three
One Two Three Four

NR

It represents the number of the current record. For instance, the following example prints the record if the current record number is less than three.

Example

[jerry]$ echo -e "One Two\nOne Two Three\nOne Two Three Four" | awk 'NR < 3'

On executing this code, you get the following result −

Output

One Two
One Two Three

FNR

It is similar to NR, but relative to the current file. It is useful when AWK is operating on multiple files. Value of FNR resets with new file.
OFMT

It represents the output format number and its default value is %.6g.

Example

[jerry]$ awk 'BEGIN {print "OFMT = " OFMT}'

On executing this code, you get the following result −

Output

OFMT = %.6g

OFS

It represents the output field separator and its default value is space.

Example

[jerry]$ awk 'BEGIN {print "OFS = " OFS}' | cat -vte

On executing this code, you get the following result −

Output

OFS =  $

ORS

It represents the output record separator and its default value is newline.

Example

[jerry]$ awk 'BEGIN {print "ORS = " ORS}' | cat -vte

On executing the above code, you get the following result −

Output

ORS = $
$

RLENGTH

It represents the length of the string matched by match function. AWK's match function searches for a given string in the input-string.

Example

[jerry]$ awk 'BEGIN { if (match("One Two Three", "re")) { print RLENGTH } }'

On executing this code, you get the following result −

Output

2

RS

It represents (input) record separator and its default value is newline.

Example

[jerry]$ awk 'BEGIN {print "RS = " RS}' | cat -vte

On executing this code, you get the following result −

Output

RS = $
$

RSTART

It represents the first position in the string matched by match function.

Example

[jerry]$ awk 'BEGIN { if (match("One Two Three", "Thre")) { print RSTART } }'

On executing this code, you get the following result −

Output

9

SUBSEP

It represents the separator character for array subscripts and its default value is \034.

Example

[jerry]$ awk 'BEGIN { print "SUBSEP = " SUBSEP }' | cat -vte

On executing this code, you get the following result −

Output

SUBSEP = ^\$

$0

It represents the entire input record.

Example

[jerry]$ awk '{print $0}' marks.txt

On executing this code, you get the following result −

Output

1) Amit     Physics   80
2) Rahul    Maths     90
3) Shyam    Biology   87
4) Kedar    English   85
5) Hari     History   89

$n

It represents the nth field in the current record where the fields are separated by FS.

Example

[jerry]$ awk '{print $3 "\t" $4}' marks.txt

On executing this code, you get the following result −

Output

Physics   80
Maths     90
Biology   87
English   85
History   89



## References

[Homebrew Website](https://brew.sh/ "Homebrew Website")
[GNU Awk Users Guide](https://www.gnu.org/software/gawk/manual/gawk.html#Regexp "GNU Awk Users Guide")
[Linuxize Enviornmental variables](https://linuxize.com/post/how-to-set-and-list-environment-variables-in-linux/ "Linuxize - Enviornmental Variables")
[Geeks for Geeks - Enviornmental Variables](https://www.geeksforgeeks.org/environment-variables-in-linux-unix/ "Geeks for Geeks - Enviornmental Variables")
