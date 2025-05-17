#!/bin/bash

#Function 1: Add Task          somaya    44510533
add_task() {
    echo "Enter task name:"
    read task_name

    echo "Enter due date (YYYY-MM-DD):"
    read due_date

    echo "Enter priority (High / Medium / Low):"
    read priority

    # check date format
    if ! date -d "$due_date" &>/dev/null; then
        echo "Invalid date format. Use YYYY-MM-DD."
        return
    fi

    echo "$task_name | $due_date | $priority" >> "tasks.txt"
    echo "Task added successfully!"
}

# function 2      ruyuf        id









#Function 3: Remind Tasks                somaya     44510533
remind_tasks() {
    echo "Checking for upcoming tasks..."
    today=$(date +%s)

    if [ ! -f "tasks.txt" ]; then
        echo "tasks.txt not found."
        return
    fi

    while IFS="|" read -r name date priority; do
        task_date=$(date -d "$date" +%s 2>/dev/null)

        # Skip if date is invalid
        if [ -z "$task_date" ]; then
            continue
        fi

        days_left=$(( (task_date - today) / 86400 ))

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
    remind)
        remind_tasks
        ;;
    *)
        echo "Use: $0 {add | remind}"
        ;;
esac








