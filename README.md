# bookslog
track reading from the command line CLI

# future state
working toward a future where you can use books log to log a book, search for a book to see what you have, update your logs, handle multiple reads, and get summary data about your reading

# current state
you can log a book. the intreaction looks like so (but with color). A soon as the book's title is given, a file is created in `/logs` with the details for the book. 

```
~/bookslog on  main! ⌚ 19:38:56
$ bash books.sh                   
>> Yes! Updating Books!
What do you want to do:
 1. Log a Book
 2. Search Books
 3. Exit
>> Enter your choice (1-3): : 1
>> Log a Book will guide you fill-in-the-blank style
use quotes around 'strings with spaces', otherwise type normally
>> press Ctrl+C to exit <<
>> Book Title: : "Dog of Aluminum"
>> Author: : "i made it up"
>> Format print (p) or audio (a): : a
>> How many minutes (approx)?: : 222
>> Your Rating (1-5): : 5
>> Do you want to enter start finish dates? (y/n): : y
>> Start date (YYYY-MM-DD): : 2025-01-20
>> Finish date (YYYY-MM-DD): : 2025-01-30
>> 10 days spent reading
>> 22.20 minutes per day
```

