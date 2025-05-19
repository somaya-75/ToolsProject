#!/bin/bash

#Function 1: Add Task         name:somaya     id:44510533
add_task() {
    echo "Enter task name:"
    read task_name

    echo "Enter due date (YYYY-MM-DD):"
    read due_date

    echo "Enter priority (High / Medium / Low):"
    read priority

    #Check if date format is valid
    if ! date -d "$due_date" &>/dev/null; then
        echo "Invalid date format. Use YYYY-MM-DD."
        return
    fi

    # Save task to file
    echo "$task_name | $due_date | $priority" >> "tasks.txt"
    echo "Task added successfully!"
}


#Function 2: list tasks      name:ruyuf      id:44510064
list_tasks() {
  # Check if tasks file exists
  if [[ ! -f tasks.txt ]]; then
    echo "Error: tasks.txt not found!"
    return 1
  fi
  # Display tasks
  cat tasks.txt
}


#Function 3: Remind Tasks             name:somaya      id:44510533
remind_tasks() {
    echo "Checking for upcoming tasks..."
    today=$(date +%s) # Get current date in seconds

    # Make sure the tasks file exists
    if [ ! -f "tasks.txt" ]; then
        echo "tasks.txt not found."
        return
    fi
    # Read each line from tasks.txt
    while IFS="|" read -r name date priority; do
        task_date=$(date -d "$date" +%s 2>/dev/null)

        # Skip if date is invalid
        if [ -z "$task_date" ]; then
            continue
        fi
       # Calculate how many days left
        days_left=$(( (task_date - today) / 86400 ))

# Show reminder if task is due in 2 days or less
        if [ "$days_left" -le 2 ] && [ "$days_left" -ge 0 ]; then
            echo -e "\e[31mReminder:\e[0m \"$name\" is due in $days_left day(s)! (Priority: $priority)"
        fi
    done < "tasks.txt"
}
#Command Line Interface
case "$1" in
    add)
        add_task
        ;;
    list)
        list_tasks
        ;;
    remind)
        remind_tasks
        ;;
    *)
        echo "Use: $0 {add | list | remind}"
        ;;
esac








