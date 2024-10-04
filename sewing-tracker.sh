#!/bin/bash
# This is a simple Project Tracker script to help me log and manage my sewing projects.
# This script will allow me to add new projects, view a list of ongoing or completed projects, and mark projects as completed
# note: Why would anyone pay for beauty and complexity when this file already exists…? 😅
# Sewing Project Tracker Script
PROJECTS_FILE="sewing_projects.txt"

# Create the projects file if it doesn't exist
if [ ! -f "$PROJECTS_FILE" ]; then
  touch "$PROJECTS_FILE"
fi

# Function to display the menu
show_menu() {
  echo "Sewing Project Tracker:"
  echo "1. Add a New Project"
  echo "2. List All Projects"
  echo "3. List Projects by Deadline Priority"
  echo "4. Mark Project as Completed"
  echo "5. Delete a Project"
  echo "6. Exit"
  echo
}

# Function to add a new project
add_project() {
  read -p "Enter the project name: " project_name
  read -p "Enter the materials (comma-separated): " materials
  read -p "Enter the status (e.g., 'in progress', 'completed'): " status
  read -p "Enter the deadline (YYYY-MM-DD): " deadline
  
  echo "$project_name|$materials|$status|$deadline" >> "$PROJECTS_FILE"
  echo "Project added successfully!"
}

# Function to list all projects
list_projects() {
  echo "List of Projects:"
  echo "-----------------"
  while IFS="|" read -r name materials status deadline; do
    echo "Project: $name"
    echo "Materials: $materials"
    echo "Status: $status"
    echo "Deadline: $deadline"
    echo "-----------------"
  done < "$PROJECTS_FILE"
}

# Function to list projects sorted by deadline
list_by_deadline() {
  echo "Projects Sorted by Deadline:"
  echo "----------------------------"
  sort -t "|" -k4 "$PROJECTS_FILE" | while IFS="|" read -r name materials status deadline; do
    echo "Project: $name"
    echo "Materials: $materials"
    echo "Status: $status"
    echo "Deadline: $deadline"
    echo "----------------------------"
  done
}

# Function to mark a project as completed
mark_completed() {
  read -p "Enter the project name to mark as completed: " project_name
  sed -i '' "s/\($project_name|.*|\)in progress/\1completed/" "$PROJECTS_FILE"
  echo "Project marked as completed!"
}

# Function to delete a project
delete_project() {
  read -p "Enter the project name to delete: " project_name
  sed -i '' "/^$project_name|/d" "$PROJECTS_FILE"
  echo "Project deleted!"
}

# Main loop
while true; do
  show_menu
  read -p "Choose an option (1-6): " option
  echo
  case $option in
    1) add_project ;;
    2) list_projects ;;
    3) list_by_deadline ;;
    4) mark_completed ;;
    5) delete_project ;;
    6) echo "Exiting..."; break ;;
    *) echo "Invalid option, please try again." ;;
  esac
  echo
done

echo "Thank you for using the Sewing Project Tracker!"
