import re
import sys
import subprocess


template="""
<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="utf-8">
      <title>siddharth dushantha</title>
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <link rel="stylesheet" href="../style.css">
      <link href="data:image/png;base64," rel=icon type="image/png">
   </head>
      <div>
        <a id="navigation" href="../">[home]</a>
        <h1>{title}</h1>
        <small>{date}</small>
        {content}
   </div>
</html>
"""

md_file = sys.argv[1]
md = open(md_file, "r+").read()

fname = re.findall("md\/(.*?)\.md", md_file)[0]

title = re.findall("^# .*", md)[0].replace("# ", "")

content = subprocess.run(["pandoc", md_file], stdout=subprocess.PIPE).stdout.decode('utf-8')

site = template.format(title=title, date="11 Sep 2019", content=content)

print(site)
