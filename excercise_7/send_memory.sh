#!/ur/bin/bash

# File to store memory usage data
MEMORY_LOG_FILE="/home/vagrant/altschool/memory_logs/ram_memory.log"

# Email address to send the report
EMAIL_ADDRESS="devprinceng@gmail.com"

# Function to create a new log file
function create_log_file {
    if [ -f "$MEMORY_LOG_FILE" ]; then
        rm -f "$MEMORY_LOG_FILE"
    fi
    touch "$MEMORY_LOG_FILE"
    #append date in log file using the format below
    date +"%Y-%m-%d %H:%M:%S" >> "$MEMORY_LOG_FILE"
    # get the first 2 rows, i.e headings & the memory usage in human readable format(-h)
    free -h | head -n 2 >> "$MEMORY_LOG_FILE"
    echo "------------------------" >> "$MEMORY_LOG_FILE"

    # Email subject
    subject="VM Memory Usage Report - $(date +"%Y-%m-%d")"

    # Read the content of the memory file and save to body variable
    body=$(cat "$MEMORY_LOG_FILE")

    # Use your mail command or a service like mailx, mutt, or mail to send the email
    # Replace the placeholders with your email server details
    mail -s "$subject" "$EMAIL_ADDRESS" <<< "$body"
}

# Call the function to create the log file
create_log_file
