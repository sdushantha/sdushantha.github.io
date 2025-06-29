# /usr/bin/env bash
#
# Siddharth Dushantha 2025
#
# Build script for building my site
# https://github.com/sdushantha/sdushantha.github.io
#

shopt -s extglob nullglob

rm -rf site
mkdir -p site/post

# Use a temporary directory to setup the templates by injecting
# the navbar into them.
tmp_templates=$(mktemp -d)
trap 'rm -rf "$tmp_templates"' EXIT

navbar=$(<templates/navbar.html)

# Inject navbar into all templates
for template_name in index post generic; do
    template=$(<templates/$template_name.html)
    echo "${template//<\!-- NAVBAR -->/$navbar}" > "$tmp_templates/$template_name.html"
done

feed=()

# Build the blog posts
for mdpost in src/posts/*.md; do
    name=$(basename $mdpost .md)
    date=$(grep -Po "^date:\s*\K.*" $mdpost)
    title=$(grep -Po "^title:\s*\K.*" $mdpost)

    pandoc "$mdpost" -o "site/post/$name.html" --template="$tmp_templates/post.html"

    feed+=("<p>$date  <a href=\"/post/$name.html\">$title</a></p>")
    echo -e "\e[32m✔\e[0m Built Post: $title"
done

feed=$(printf '%s\n' "${feed[@]}" | sort -r)

echo "$feed" |
    sed "/%%FEED%%/r /dev/stdin" "$tmp_templates/index.html" |
    sed "/%%FEED%%/d" > site/index.html


# Build other pages
for mdfile in src/*.md; do
    name=$(basename $mdfile .md)
    pandoc "$mdfile" -o "site/$name.html" --template="$tmp_templates/generic.html"
    echo -e "\e[32m✔\e[0m Built Page: $name.html"
done

cp src/!(*.md) site 2>/dev/null

echo -e "\e[32m✔\e[0m Build Complete"
