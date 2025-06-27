

rm site/post/*

feed=()

for mdfile in posts/*.md; do
    name="$(basename $mdfile .md)"
    date=$(grep -Po "^date:\s*\K.*" $mdfile)
    title=$(grep -Po "^title:\s*\K.*" $mdfile)

    pandoc "$mdfile" -o "site/post/$name.html" --template=templates/post.html

    feed+=("<p>$date  <a href=\"/post/$name.html\">$title</a></p>")
    echo -e "\e[32m✔\e[0m Finished building $title"
done

# TODO: reuse feed variable???
feed_index=$(printf '%s\n' "${feed[@]}" | sort -r)

echo "$feed_index" |
    sed -E "/%%FEED%%/r /dev/stdin" templates/index.html |
    sed -E "/%%FEED%%/d" > site/index.html

echo -e "\e[32m✔\e[0m Feed updated"
