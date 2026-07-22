BEGIN {
    front_matter_fence_count = 0
    strip_preamble = 0
}
{
    if ($0 ~ /^---[[:space:]]*$/ && front_matter_fence_count < 2) {
        front_matter_fence_count++
        print

        if (front_matter_fence_count == 2) {
            strip_preamble = 1
        }
        next
    }

    if (front_matter_fence_count < 2) {
        print
        next
    }

    if (strip_preamble == 1) {
        # skip over everything between the yaml header and the first ## slide
        if ($0 ~ /^##[[:space:]]+/) {
            strip_preamble = 0
            print
        }
        next
    }

    print
}
