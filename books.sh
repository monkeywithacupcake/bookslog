#!/bin/sh

# Display a welcome message
echo "Yes! Updating Books"

# Present a menu of options
echo "What do you want to do:"
echo "1. Log a Book"
echo "2. Search Books"
echo "3. Exit"

# Read the user's choice
read -p "Enter your choice (1-3): " choice

# TODO: handle annual (or other) summary printings


generate_safe_filename() {
  local input_string="$1"
  # Replace spaces with underscores
  input_string="${input_string// /_}"
  # Remove or replace special characters (excluding alphanumeric, underscore, hyphen, and period)
  input_string=$(sed 's/[^a-zA-Z0-9._-]//g' <<< "$input_string")
  # Make it all lower case
  input_string="$(tr [A-Z] [a-z] <<< "$input_string")"
  # Truncate to a maximum length (e.g., 64 characters)
  max_length=64
  if [[ ${#input_string} -gt "$max_length" ]]; then
    input_string="${input_string:0:$max_length}"
  fi
  # Remove leading/trailing periods and underscores
  input_string=$(sed 's/^[._-]*//;s/[._-]*$//' <<< "$input_string")
    
  echo "$input_string.txt"
}

is_valid_date() {
    local xd="$1"
    local date_format="%Y-%m-%d"
    [[ "$(date "+$date_format" -d "$xd" 2>/dev/null)" == "$xd" ]]
}


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
    echo "Log a Book"
    read -p "Book Title: " book_title
    safe_name=$(generate_safe_filename "$book_title")

    if [[ ! -e ./logs/$safe_name ]]; then
        echo "Title: $book_title" >> ./logs/$safe_name
    else echo "File $safe_name already exists"
    fi

    read -p "Author: " book_author
    echo "Author: $book_author" >> ./logs/$safe_name
    read -p "Format print (p) or audio (a): " book_pa
    if [[ "$book_pa" = "p" ]]; then
     echo "Format: Print" >> ./logs/$safe_name
     read -p "How many pages?: " book_pages
     echo "Pages: $book_pages" >> ./logs/$safe_name
    else 
     echo "Format: Audio" >> ./logs/$safe_name
     read -p "How many minutes (approx)?: " book_minutes
     echo "Minutes: $book_minutes" >> ./logs/$safe_name
    fi
    # rating
    read -p "Your Rating (1-5): " book_rating
    echo "Rating: $book_rating" >> ./logs/$safe_name
    # TODO: handle dates
    read -p "Do you want to enter start finish dates? (y/n): " add_dates
    if [[ "$add_dates" =~ ^[Yy]$ ]]; then
        #while true; do
            read -p "Start date (YYYY-MM-DD): " start_date
            #if is_valid_date "$start_date"; then
            #    break
            #else
            #echo "Invalid input. Please try again."
            #fi
        #done
        echo "You entered: $start_date"
        echo "Start: $start_date" >> ./logs/$safe_name
        #while true; do
            read -p "Finish date (YYYY-MM-DD): " finish_date
            #fgood=$(is_valid_date "$finish_date")
            #if [[ $fgood = 'good' ]]; then
            #    break
            #else
            #echo "Invalid input. Please try again."
            #fi
        #done
        echo "You entered: $finish_date"
        echo "Start: $finish_date" >> ./logs/$safe_name
    fi
    ;;
  2)
    echo "Search Books"
    # find the book
    read -p "Book Title: " book
    grep -ril $book .
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
