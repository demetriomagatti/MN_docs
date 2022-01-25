# Tryng to understand R scripts for analysis

This is just me trying to make some sense out of a HUGE amount of code which was born years ago and has been modified by different people in time. What we are working with is lots of mixed styles, almost identical groups of line repeated in the same file and maybe some comment here and then but I don't have much hope about that. 

## Project layout

I'll just go over the files and make my personal comments/explanation of what a script does. In-text variables, filenames, commands will be formatted as `command example`.

Many-line codes chunk will be put together in a gray box, as following:

```bash
first code line
second code line
```

Every now and then, we'll be interest in some command's output. It will still be enveloped in a box, but will also have an extra indentation block and will be red-colored:
```bash
this is a command
```
> `and this is its output`

A the end of each section, I'll add a list of possible changes for a clearer and more maintainable code.

## Inspecting strategy

First thing I'll do is build up an hierarchy. For each inspected .r script, I will name the other .r scripts it *sources*. The approach will then be *from big to small* in the first phase, and then switch to *from small to big*, with more detailed analysis that starts with scripts that don't call any other one and goes its way up to the scripts that call many. 

## Possible changes 

While browsing script files, I'll take notes of maybe-too-long code chunks and suggest a personal idea to shorten the code and improve readability, if I am capable of that, and of this I'm not entirely sure. I'll try my best, I guess. Code lines' numbers are reported for quoted code chunks, but they're just "approximate" since the code is subject to changes and I am taking a local, unupdated version as a reference. 