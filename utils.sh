#!/bin/bash

# utility functions for bookslog

#####################
# Pretty Functions
#
# styles
bold=$(tput bold)
CYAN=$(tput setaf 14)
MAG=$(tput setaf 5)
NC=$(tput sgr0)

# Function to show pretty text
pretty_print(){
  local the_text="$1"
  echo "${bold}${MAG}>> ${CYAN}$the_text${NC}"
}
# Function to display the prompt and read input
prompt_user() {
  local prompt_text="$1"
  local variable_name="$2"
  
  printf "${MAG}>> ${CYAN}%s${NC}: " "$prompt_text"
  read "$variable_name"
}

#####################
# String Functios
#
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

#####################
# Date Functions
#
# Function to validate if a date is within a range
validate_date_range() {
  # use like
  #validate_date_range "$date_to_check" "$start_date" "$end_date"
  local date_to_check="$1"
  local start_date="$2"
  local end_date="$3"
  local d_format='%Y-%m-%d' 
  # Convert dates to timestamps
  local timestamp_check=$(date -j -f "$d_format" "$date_to_check" +%s)
  local timestamp_start=$(date -j -f "$d_format" "$start_date" +%s)
  local timestamp_end=$(date -j -f "$d_format" "$end_date" +%s)

  # Check if the conversion was successful
  if [[ -z "$timestamp_check" || -z "$timestamp_start" || -z "$timestamp_end" ]]; then
    echo "Error: Invalid date format. Please use a format that 'date' can understand."
    return 1
  fi
  if [[ "$timestamp_check" -ge "$timestamp_start" && "$timestamp_check" -le "$timestamp_end" ]]; then
    return 0
  else
    return 1
  fi
}

calc_days_between_dates(){
  # use like calc_days_between_dates a_day another_day
  local date1="$1"
  local date2="$2"
  local d_format='%Y-%m-%d' 
  # Convert dates to timestamps
  local timestamp1=$(date -j -f "$d_format" "$date1" +%s)
  local timestamp2=$(date -j -f "$d_format" "$date2" +%s)
  
  diff_seconds=$((timestamp2 - timestamp1))
  diff_days=$((diff_seconds / 86400))

 echo "$diff_days"
}

