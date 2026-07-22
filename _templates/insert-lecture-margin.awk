BEGIN {
    front_matter_fence_count = 0
    inserted = 0
}
{
    # needed to print the entire file
    print

    # look for the begin/end of the front matter fence block
    if ($0 ~ /^---[[:space:]]*$/) {
        front_matter_fence_count++

        if (front_matter_fence_count == 2 && inserted == 0) {
            print ""
            while ((getline line < links_template) > 0) {
                gsub("__STEM__", stem, line)
                print line
            }
            close(links_template)
            print ""
            inserted = 1
        }
    }
}
