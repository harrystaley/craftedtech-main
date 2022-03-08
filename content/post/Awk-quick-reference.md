---
title: "AWK: the text data processing chainsaw"
date: 2021-10-10T17:00:00-06:00
draft: false
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
Line1c1 Line1c2
Line2c1 Line2c2
Line3c1 Line3c2
Line4c1 Line4c2
```
3. Lets execute our first awk command on our file.
Input:
```bash
awk 'BEGIN{printf "---Begin Block---"} {print} END{printf "---End Block---"}' myfile.txt
```
Output:
```bash
---Begin Block---
Line1c1 Line1c2
Line2c1 Line2c2
Line3c1 Line3c2
Line4c1 Line4c2
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
Line1c1 Line1c2
Line2c1 Line2c2
Line3c1 Line3c2
Line4c1 Line4c2
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
```bash
awk 'BEGIN { print "Number Conversion Format =", CONVFMT }'
```
Output:
```bash
Number Conversion Format = %.6g
```
### ENVIRON
ENVIRON is an associative array for environmental variables.
Input:
```bash
awk 'BEGIN { print ENVIRON["USER"] }'
```
Output:
```bash
someuser
```
To find other environment variables, use ```env``` command. To learn more about enviornmental variables see [Linuxize Enviornmental variables](https://linuxize.com/post/how-to-set-and-list-environment-variables-in-linux/ "Linuxize - Enviornmental Variables").

### FILENAME

FILENAME stores the current file name.

Input:
```bash
awk 'END {print FILENAME}' myfile.txt
```
Output:
```bash
myfile.txt
```
NOTE: FILENAME is an undefined variable in the BEGIN block.

### FS

FS represents the (input) field delineator. The default value is a space " ". You may also change this by using -F terminal option.

Input:
```bash
awk 'BEGIN {print "FS = " FS}' | cat -vte
```
Output:
```bash
FS =  $
```
### NF
NF stores the number of fields in the current record.

For example, the below prints only lines containing more than three fields.

Input:
```bash
echo -e "field1 field2\nfield1 field2 field3\nfield1 field2 field3 field4" | awk 'NF > 3'
```
Output:
```bash
field1 field2 field3 field4
```
### NR

NR stores the number of the current record.

For instance, the below prints the record if the current record number is less than 4.

Input:
```bash
echo -e "One\nTwo\nThree\nFour" | awk 'NR < 4'
```
Output:
```bash
One
Two
Three
```
### FNR
FNR is simmilar to NR, but is relative to the current input stream.

This is particularly useful when Awk is working with multiple input streams as such the value of FNR resets with each new input stream.

### OFMT
OFMT stores the output format number. The default value is %.6g.

Input:
```bash
awk 'BEGIN {print "OFMT = " OFMT}'
```
Output:
```bash
OFMT = %.6g
```
### OFS

OFS stores the output field separator. Its default value is space " ".

Input:
```bash
awk 'BEGIN {print "OFS = " OFS}' | cat -vte
```
Output:
```bash
OFS =  $
```
### ORS

ORS stores the output record delineator. Its default value is newline "\n".

Input:
```bash
awk 'BEGIN {print "ORS = " ORS}' | cat -vte
```
Output:
```bash
ORS = $
$
```
### RLENGTH

RLENGTH stores the string length matched by the match function.

AWK's match function searches for a given string in the input-string.

Input:
```bash
awk 'BEGIN{ if (match("One Two Three", "re")) { print RLENGTH } }'
```
Output:
```bash
2
```
### RS

RS stoes (input) record separator.
Its default value is newline "\n".

Input:
```bash
awk 'BEGIN {print "RS = " RS}' | cat -vte
```
Output:
```bash
RS = $
$
```

### RSTART

RSTART stores the first position in the string matched by match function.

Input:
```bash
awk 'BEGIN { if (match("The quick brown fox", "bro")) { print RSTART } }'
```

Output:
```bash
11
```
### SUBSEP

SUBSEP stores the separator character for array subscripts.
The default value is \034.

Input:
```bash
awk 'BEGIN { print "SUBSEP = " SUBSEP }' | cat -vte
```

Output:
```bash
SUBSEP = ^\$
```

### $0

$0 stores the entire input stream.

Input:
```bash
awk '{print $0}' myfile.txt
```
Output:
```bash
Line1c1 Line1c2
Line2c1 Line2c2
Line3c1 Line3c2
Line4c1 Line4c2
```

### $n

$n stores the nth field of the input stream which is delineated by FS.

For example if I wanted to print the second field of myfile.txt.

Input:
```
awk '{print $2}' myfile.txt
```
Output:
```
Line1c2
Line2c2
Line3c2
Line4c2
```

## Regular Expressions a.k.a. REGEX

AWK powerfully and effectively handles regular expressions. Numerous problems can be solved with simple regular expressions.  As this article does not cover regular expressions themselves please see the reference section of this blog post. That being said see below some of the implementations of regex in Awk.

Method 1:
Execute a body block on a line only if something in the line matches the pattern.

awk '/some-regex/ {do-awk-stuff}' target_input_stream

Input:
```
 awk '/e2/ {print}' myfile.txt
 ```
Output:
```
Line2c1 Line2c2
```

Method 2:
Your regular expression can also be used in a conditional argument as seen below.

In this case it can either take the form of ```~``` is Like or ```!~``` is Not like.

```
awk '{if ($n ~ /some-regex/) {do-awk-stuff}}' target_input_stream
```
or

```
awk '{if ($n !~ /some-regex/) {do-awk-stuff}}' target_input_stream
```
Here is another way to write our first regex example.
Input:
```
 awk '{if ($0 ~ /e2/) {print}}' myfile.txt
 ```
Output:
```
Line2c1 Line2c2
```
If I wanted to search in the second column and return data from the second column.
Input:
```
 awk '{if ($2 ~ /e2/) {print $2}}' myfile.txt
```
Output:
```
Line2c2
```

For more on regular experssions please see the following sites that I have found helpful.

[Rexegg - Regex quick Start guide](https://www.rexegg.com/regex-quickstart.html "Rexegg - Regex quick start guide")

[Regex 101 - BUild Test and Debug Regualr Experssions](https://regex101.com/ "Regex 101 - Build Test and Debug Regular Expressions")



## References

[Homebrew Website](https://brew.sh/ "Homebrew Website")

[GNU Awk Users Guide](https://www.gnu.org/software/gawk/manual/gawk.html#Regexp "GNU Awk Users Guide")

[Linuxize Enviornmental variables](https://linuxize.com/post/how-to-set-and-list-environment-variables-in-linux/ "Linuxize - Enviornmental Variables")

[Geeks for Geeks - Enviornmental Variables](https://www.geeksforgeeks.org/environment-variables-in-linux-unix/ "Geeks for Geeks - Enviornmental Variables")

[Regex 101 - BUild Test and Debug Regualr Experssions](https://regex101.com/ "Regex 101 - Build Test and Debug Regular Expressions")

[Rexegg - Regex quick Start guide](https://www.rexegg.com/regex-quickstart.html "Rexegg - Regex quick start guide")
