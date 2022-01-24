# Introduction

**Bash** is a command language **interpreter**. **Scripting** allows automatic command execution (commands executed one-by-one). You open up a file with a text editor, type in the list of commands and save it to say `filename.sh`. On the inside, a very simple file looks like
```bash
date
ls
```
The two commands `date` and `ls` are executed one after the other. Once it is saved, you can make it executable by typing
`chmod +x filename.sh`
in the shell, and then execute the whole script by typing
`./filename.sh`
again in the shell. <br><br>
Bash itself is the default interpreter on many Linux systems. It is not the only one available though, so it is common practice to define the interpreter to be used explicitly in the beginning of the script. Hence, all of our scripts will (usually) begin with `#!/bin/bash`. <br><br>
Let’s go back to the `chmod +x filename.sh` command and talk a bit about it. By default, any newly created file is not executable regardless of its extension suﬀix. Another way to execute the script without making it executable first is to explicitly call the bash interpreter in the shell, i.e. `bash filename.sh`.

## Hello World
What an uncommon first script example. It’s actually quite easy; we just need to use the `echo` command which basically prints its argument (i.e. whatever follows, no parenthesis needed). The `HelloWorld.sh` script then looks like
```bash
#!/bin/bash 

echo "Hello World"
```
and it then needs to be either made executable or executed by explicitly invoking the interpreter.

## Commands and arguments
Most commands accept so called options and arguments. Command options are used to modify command’s behaviour to produce alternative output results and are prefixed by a `-` symbol. Arguments may specify additional things, for example the target file. Each command comes with a manual page which can be displayed with the `man` command. To quit from the manual page, just press the `q` key.

## Variables
If you’re a bit familiar with programming, you’ll certainly be familiar with variables. Let’s see ho to define and use variables in bash. Here’s the nice and brief `welcome.sh ` script
```bash
#!/bin/bash

greeting="Welcome"
user=$(whoami)
day=$(date +%A)
echo "$greeting back $user! Today is $day, which is the best day of the entire week!"
echo "Your Bash shell version is: $BASH_VERSION. Enjoy!"
```

Value assignment is done via the `=` symbol, nothing fancy or strange about that. It is important **not to leave any space** between the `h` symbol and whatever comes before/after: if a space is left, bash will interpret `greeting` as a command and return a "command not found" error. `whoami` and `date` are commands; the `$` symbol, in combination with the `=`, allows to assign the command's output to a specific variable. This is what happens in corresponding code lines. The characters`+%A` serve the purpose of selection a specific date format option (full weekday name). <br><br>
Variables can also be used directly on the terminal’s command line. The following example declares variables `a` and `b` with integer data. Using the `echo` command, we can print their values or even perform an arithmetic operation.
```bash
a=4
b=8
echo $a
```
> `4`
```bash
echo $[$a+$b]
```
> `12`

Again, it is important to **enclose the operation between square braces and add a `$` before the expression**, or bash will again interpret `[$a+$b]` as a command and return an error. It is pretty clear by now that the `$` symbol is used to ”refer to” an already existing object, whether it is a variable or a command output.

## A first 10-rows-long script
By combining the incredible knowledge built in these two pages, let’s write a backup script that stores all the content of a selected directed into an archive.

```bash
#!/bin/bash

# This bash script is used to backup a user's home directory to /tmp/.

user=$(whoami)
input=/home/$user
output=/tmp/${user}_home_$(date +%Y-%m-%d_%H%M%S).tar.gz

tar -czf $output $input
echo "Backup of $input completed! Details about the output backup file:"
ls -l $output
```
We actually introduced some new things here. If you have any minor experience with programming, you should know that programming languages allow to add comments, i.e. lines ignored by the interpreter when the script is executed. Different languages have different characters to tell the interpreter that a line is a comment line, and bash uses the `#` symbol. <br><br>
The `tar` command, together with the `-czf` option, creates the backup archive. One can look at the [tar manual page](https://www.commandlinux.com/man-page/man1/tar.1.html) to see all the possible options, but here `-czf` stands for **c**reate, filter archive through gzip, **f**ilename; the first argument it takes is the filename of the archive we  want to create, and it is therefore the content of our `output` variable; the last needed argument is ”where to get the files to store in the archive”, and that is told by `input`. Finally, the `ls` command outputs a list of the content in a specific directory, and the `-l` option (*long*) just tells the command to show more information than it would by just calling `ls $output`. <br><br>
There’s actually one thing that you might have missed. From the [bash manual](https://devhints.io/bash) : *”The `$` character introduces parameter expansion, command substitution, or arithmetic expansion. The parameter name or symbol to be expanded may be enclosed in braces, which are optional but serve to protect the variable to be
expanded from characters immediately following it which could be interpreted as part of the name.”*. In simple words, braces are put there just because something immediately follows the variable name, but we need a way to tell bash where the variable name ends. In other cases we can just insert a white space by pressing the space bar, but here that’s not an option because it would ”break” the path for the creation of our backup archive.

## Output and error redirections
Normally commands executed on GNU/Linux command line either produce output, require input or throw an error message. Every time you execute a command, three possible outcomes might happen. The first scenario is that the command will produce an expected output; in the second case, the command will generate an error; lastly,
your command might not produce any output at all. Let's suppose we are in an empty directory and we run the following chunk:
```bash
ls -l foobar
```
> `ls: cannot access 'foobar': No such file or directory`
```bash
touch foobar
ls -l foobar
```
> `foobar`

In the first line, we ask bash to give us information on the foobar file. It doesn’t exist, and so an error is raised. We then create it using the `touch` command (if you
want more info, the manual page is always there), and now the ls command is able to retrieve and give us information. The standard output produced if no error arises is referred to as **stdout**, while the error message is referred to as **stderr**. <br><br>
Now we talk redirection. Again, we explain things with a brief example chunk of lines. Suppose we are in the same directory as before, with only the `foobar` file present.
```bash
ls foobar barfoo
```
> `ls: cannot access 'barfoo': No such file or directory`<br>
> `foobar`

`ls` looks for both  `foobar` and `barfoo` files. It finds the first one but not the second. It then returns one standard error message and one standard output message.

```bash
ls foobar barfoo > stdout.txt
```
> `ls: cannot access 'barfoo': No such file or directory`

The `>` symbol redirects the standard output to a specified file; only the standard error message is printed.

```bash
ls foobar barfoo 2> stderr.txt
```
> `foobar`

The `2>` symbol redirects the standard error to a specified file; only the standard output message is printed.

```bash
ls foobar barfoo &> stdoutandstderr.txt
```

The `&>` symbol redirects both the standard output and error to a specified file; nothing is printed. If we now were to explore the content of such files, we would find:
```bash
cat stdout.txt
``` 
> `foobar`

```bash
cat stderr.txt
```
> `ls: cannot access 'barfoo': No such file or directory` 

```bash
cat stdoutandstderr.txt
```
> `ls: cannot access 'barfoo': No such file or directory`<br>
> `foobar`

As you may have inferred, the `cat` command prints out the content of a target file. 

## Functions
I will again assume I am not talking to somebody who’s totally new to coding and therefore has an idea of what a function is and can be used for. I’ll just put here an example of a simple function definition and call in a veeeery brief script which we will call `function.sh`. Suppose the output of the `whoami` command is ”demetrio” and the output of the `HOME` command is ”demetrios_home” (please note the huge amount of imagination I used here).
```bash
!/bin/bash

function user_details{
    echo "User name: $(whoami)"
    echo "Home directory: $HOME"
}

user_details
```
The function we defined is called `user_details` and the definition process is actually quite simple. You just type function followed by the function name and embrace the commands list of the function between braces. The indentation is arbitrary and not necessary, but it is always helpful to understand where a function starts and ends. If you are familiar with functions (and maybe you’re into Python, just like me), you may notice the absence of the `return`. As we will see, there’s no need to introduce it. To call the function, you just type its name. Let’s execute the script in the shell:
```bash
chmod +x function.sh
./function.sh
```
> `User name: demetrio` <br>
> `Home directory: demetrios_home`

Let us introduce another function, actually not to add any knowledge on functions themselves but to introduce a couple of new commands and the first "live input".
```bash
function total_files{
    find $1 -type f | wc -l    
    }
```
Such short function returns the number of files located in a directory. Again, no `return` is needed. The `find` command, as you may have innferred, is the command that seaarches for files in the directory. "Which directory?", you ask? That's what the `$1` is there for. Once the function is called, it awaits for an argument to be passed to it manually, and that argument is (in this case) the directory to be explored. After that, the `-type f` option tells bash *what to look for* in the directory (**f** for **f**iles). The vertical bar `|` is commonly referred to as **pipe**, and it is used to pipe one command into another. That is, it directs the output from the first command into the input of the second command. Such second command is `wc`, which stands for **w**ord **c**ount. together with the `-l` option, it returns the total number of files. A bit more is to come here when I get to experiment on my linux laptop. 

## Numeric and String Comparisons
Using comparisons, we can compare strings (words, sentences) or numbers whether raw or as variables. As usual, let's see an example
```bash
a=1
b=2
[$a -lt $b]
echo $
```
> `0`

We just assigned the values 1 and to 2 to variables `a` and `b`< respectively. We then evaluate the logical expression `[$a -lt $b]`, where `lt` stands for **l**ess **t**hen, and run the `echo`  command; by just typing the plain `$` symbol not followed by a variable, bash retrievs re results of the last evaluaton, in this case the result of the logical expression. If it's not the first time you see logical expressions, the result `0` is likely to have left you pretty astonished. Unlike any other programming language I hav eseen so far (and they may not be many, but there's a few ones), in bash *0 stands for TRUE and 1 stands for FALSE*. A table listing the rudimentary comparison operators for both numbers and strings follows.
| Description      | Numeric comparison |   String comparison  |
| ----------- | ----------- | ----------- |
| less than      | -lt      | <  |
| greater than      | -gt      | >  |
| equal      | -eq      | ==  |
| not equal      | -ne      | != |
| less or equal      | -le      |   |
| greater or equal      | -ge      |   |

No problem regarding numeric values comparison and in string equal/not equal to another string case, but you may actually wonder what does it mean that a string is greater than another. The "greater than" operator returns `TRUE` *if the left operand is greater than the right sorted by alphabetical order*, i.e. if the second string comes after the other once they have been sorted in alphabetical order.
