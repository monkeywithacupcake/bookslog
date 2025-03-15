#!/bin/bash

source utils.sh
source analytics.sh

today=$(date +%Y-%m-%d)

# Display a welcome message
pretty_print "Yes! Updating Books!"

trap 'echo "Exiting...Any Book Information you entered is saved"; exit 0' SIGINT

while true
do
# Present a menu of options
echo "What do you want to do:"
echo " 1. Log a Book"
echo " 2. Search Books"
echo " 3. Exit"

# Read the user's choice
prompt_user "Enter your choice (1-3): " choice

# TODO: handle annual (or other) summary printings

#handle_answer() {
    # TODO make a generic handler to ensure
    # not bad input and allow user to exit
    # and allow user to skip question
#}
#update_book() {
    # TODO make a generic updater to allow
    # user to update previous entry
#}

# Perform actions based on the user's choice
case $choice in
  1)
    pretty_print "Log a Book will guide you fill-in-the-blank style"
    echo "use quotes around 'strings with spaces', otherwise type normally"
    echo ">> press Ctrl+C to exit <<"
    prompt_user "${bold}Book Title: " book_title
    safe_name=$(generate_safe_filename "$book_title")

    if [[ ! -e ./logs/$safe_name ]]; then
        echo "Title: $book_title" >> ./logs/$safe_name
    else err_print "File $safe_name already exists"
    break
    fi

    prompt_user "Author: " book_author
    echo "Author: $book_author" >> ./logs/$safe_name
    prompt_user "Format print (p) or audio (a): " book_pa
    if [[ "$book_pa" = "p" ]]; then
     echo "Format: Print" >> ./logs/$safe_name
     prompt_user "How many pages?: " book_pages
     book_len=$book_pages
     echo "Pages: $book_pages" >> ./logs/$safe_name
    else 
     echo "Format: Audio" >> ./logs/$safe_name
     prompt_user "How many minutes (approx)?: " book_minutes
     book_len=$book_minutes
     echo "Minutes: $book_minutes" >> ./logs/$safe_name
    fi
    # rating
    prompt_user "Your Rating (1-5): " book_rating
    echo "Rating: $book_rating" >> ./logs/$safe_name
    # handle dates
    prompt_user "Do you want to enter start finish dates? (y/n): " add_dates
    if [[ "$add_dates" =~ ^[Yy]$ ]]; then
        while true; do
            prompt_user "Start date (YYYY-MM-DD): " book_start
            if validate_date_range "$book_start" "1900-01-01" "$today"; then 
                break
            else
                err_print "Invalid input. Please try again."
            fi
        done
        echo "Start: $book_start" >> ./logs/$safe_name
        while true; do
            prompt_user "Finish date (YYYY-MM-DD): " book_finish
            if validate_date_range "$book_finish" "$book_start" "$today"; then 
                break
            else
                err_print "Invalid input. Please try again."
            fi
        done
        read_days=$(calc_days_between_dates "$book_start" "$book_finish")
        echo "Finish: $book_finish" >> ./logs/$safe_name
        pretty_print "$read_days days spent reading"
        pretty_print "$(report_reading_per_day $book_len $read_days $book_type)"
    fi
    ;;
  2)
    echo "Search Books"
    # find the book
    read -p "Book Title: " book
    grep -ril $book ./logs
    # TODO: decide how to display a book
    # TODO: decide what to display if not found (or more than one found)
    ;;
  3)
    echo "Exiting program."
    exit 0
    ;;
  *)
    echo "Invalid choice. Please try again."
    ;;
esac

# End of program
done