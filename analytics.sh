#!/bin/bash

# book analytics functions for bookslog

#################
#
reading_per_day(){
    local book_length=$1
    local days=$2
    result=$(awk "BEGIN {printf \"%.2f\", $book_length / $days}")
    echo "$result" # pages or minutes per day
}
report_reading_per_day(){
    local book_length=$1
    local days=$2
    local book_type="$3"
    if [[ "$book_type" = "p" ]]; then 
        twrd="pages"
    else
        twrd="minutes"
    fi
    rpd=$(reading_per_day $book_length $days)
    echo "$rpd $twrd per day"
}