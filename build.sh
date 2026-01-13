#!/usr/bin/env bash
#
# Siddharth Dushantha 2025
#
# Build script for building my static site.
# https://github.com/sdushantha/sdushantha.github.io
#
# Dependencies: pandoc
#

# extglob: Add support for advanced globbing
# nullglob: Dont return the pattern if nothing is found
shopt -s extglob nullglob

# Use a temporary directory to setup the templates by injecting
# the navbar into them.
tmp_templates=$(mktemp -d)
trap 'rm -rf "$tmp_templates"' EXIT

# Checking if pandoc is installed
if ! command -v "pandoc" >/dev/null 2>&1; then
    echo -e "\e[31m✘\e[0m Could not find 'pandoc'"
    exit 1
fi

# Remove the 'site' directory in case it already exists. If this is not
# done, then the pages that were removed from 'src' wll be present in 'site'.
rm -rf site

# Create the 'site/post' directory. We call this 'post' even though
# the directory in 'src' is called 'posts'. This is to prevent any
# confusion when looking at the URL.
# 
# example.com/posts/demo-blog.html
#                 |
#                 +-- The 's' may suggest that visiting /posts shows a list of all
#                     posts, while the list of posts are actually shown on /index.html
mkdir -p site/post

navbar=$(<templates/navbar.html)

# Inject navbar into all templates
for template_name in index post generic; do
    template=$(<templates/$template_name.html)
    echo "${template//<\!-- NAVBAR -->/$navbar}" > "$tmp_templates/$template_name.html"
done

feed_array=()

# Build the posts that are written in markdown by converting them into HTML
# and inserting into a 'post' template.
for mdpost in src/posts/*.md; do
    name=$(basename "$mdpost" .md)

    # The blog posts are written in markdown and contain YAML metadata/headers
    # with date and title values. Pandoc uses these values to insert them in the
    # $date$ and $title$ placeholders. But since we need these values for the
    # feed list, we have to extract them ourselves as well.
    date=$(grep -Po "^date:\s*\K.*" "$mdpost")
    title=$(grep -Po "^title:\s*\K.*" "$mdpost")

    # Convert the markdown file to HTML and use the post.html template when doing so
    # TODO: improve this comment 
    pandoc "$mdpost" -o "site/post/$name.html" --template="$tmp_templates/post.html" --no-highlight --preserve-tabs -f markdown-smart -t html

    # Create a feed item which will be shown on index.html
    feed_array+=("<p>$date  <a href=\"/post/$name.html\">$title</a></p>")
    echo -e "\e[32m✔\e[0m Built Post: $title"
done

# Sort the feed in decending order by date
feed=$(printf '%s\n' "${feed_array[@]}" | sort -t. -k3,3nr -k2,2nr -k1,1nr )

# Replace %%FEED%% with the feed list which comes from the stdin. The
# reason for using stdin is because the contents of $feed contains 
# special characters which will mess up with the sed expression if we
# use a variable.
echo "$feed" |
    sed -e "/%%FEED%%/r /dev/stdin" \
        -e "/%%FEED%%/d" \
        "$tmp_templates/index.html" > site/index.html

# Build all other makrdown files present in the 'src' directory and use the
# 'generic' template. This template is nothing fancy, it just conatins the navbar.
for mdfile in src/*.md; do
    name=$(basename "$mdfile" .md)
    pandoc "$mdfile" -o "site/$name.html" --template="$tmp_templates/generic.html"
    echo -e "\e[32m✔\e[0m Built Page: $name.html"
done

# Copy all non-markdown files to the 'site' directory
for file in src/!(*.md); do
    # The wildcard above matches all non-markdown files, but includes
    # 'src/posts/', which we do not want.
    [[ ! -f "$file" ]] && continue
    cp "$file" site
    echo -e "\e[32m✔\e[0m Built Page: $(basename $file)"
done

echo -e "\e[32m✔\e[0m Build Complete"
