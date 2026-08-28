# Copy slides to lectures dir for processing
notdraft=()
for doc in slides/*.md; do
    # skip draft lectures
    if ! grep -q "draft:\s*true" $doc ; then
        # rename to qmd and copy to lectures directory for rendering
        stem="$(basename "$doc" .md)"
        qmd="lectures/${stem}.qmd"
        cp "$doc" "$qmd"

        # remove the title slide in the qmd version to prevent weird headings
        awk -i inplace -f _templates/strip-title-slide.awk "$qmd"

        # insert quarto divs for links to slides and code
        awk -i inplace -v stem="$stem" -v links_template="_templates/lecture-margin-links.md" -f "_templates/insert-lecture-margin.awk" "$qmd"

        # add backslash after every image link to prevent quarto from displaying subtitles
        sed -E -i 's/(!\[[^]]*\]\([^)]*\))/\1\\/g' "$qmd"

        # add the original file to the list of not drafts
        notdraft=("${notdraft[@]}" $doc)
    fi
done

if [[ -n $notdraft ]]; then
    # Convert to PDF
    npx @marp-team/marp-cli@latest --theme marp-mru.css --allow-local-files --pdf --html $notdraft

    # Convert to HTML
    npx @marp-team/marp-cli@latest --theme marp-mru.css --allow-local-files --bespoke.progress --html $notdraft
fi