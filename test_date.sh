#!/bin/bash
# Function to validate if a date is within a range
validate_date_range() {
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

  # Compare the timestamps
  if [[ "$timestamp_check" -ge "$timestamp_start" && "$timestamp_check" -le "$timestamp_end" ]]; then
    echo "Date is within the range."
    #diff_seconds=$((timestamp_end - timestamp_check))
    #diff_days=$((diff_seconds / 86400))

    #echo "Number of days between check and end: $diff_days"
    return 0
  else
    echo "Date is outside the range."
    return 1
  fi
}

calc_days_between_dates(){
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

# date_to_check="$1"
# start_date="$2"
# end_date="$3"

##date_to_check="$1"
#start_date="1900-01-01"
#end_date=$(date +%Y-%m-%d)
validate_date_range "$date_to_check" "$start_date" "$end_date"
