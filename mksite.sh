#!/usr/bin/env bash
template='<!DOCTYPE html><html lang="en"> <head> <meta charset="utf-8"> <title>siddharth dushantha</title> <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <link rel="stylesheet" href="../style.css"> <link href="data:image/png;base64," rel=icon type="image/png"> </head> <main> <div> <a id="navigation" href="../">[home]</a><h1>TITLE</h1><small>DATE</small> --CONTENT-- </div> </main></html>'

dots='<br><p class="divider"> •&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;•&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;• </p><br>'


## New line problem tho....
## in code tags

md=$1
#fname="${md%.*}"
fname=$(a=${md//md};b=${a:1:-1};echo $b)
echo $fname
title=$(egrep -m 1 "^# .*" $md | sed "s/# //g")
mysite=${template//TITLE/$title}

# Remove the first line which is the title
sed -i 1d $md

myhtml=$(pandoc $md)
mysite=${mysite//--CONTENT--/$myhtml}

# Ask the user for the date of the post
printf "Date: "
read date

# Replace DATE with the date the user provided
mysite=${mysite//DATE/$date}

# Insert the title back into the markdown file
sed -i "1 i\# $title" $md

echo $mysite > posts/"$fname.html"

#\d{0,2}\s\w{3}\s\d{4}
