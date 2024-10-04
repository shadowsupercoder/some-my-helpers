#!/bin/bash

# Fabric Needle Suggester Script
# Note: Sorry, I'm to lazy to google it.. Sewing is a stitch in time that keeps the stress away! :)

# Function to show the needle suggestion based on fabric choice
suggest_needle() {
  echo "Choose a fabric type:"
  echo "1. Cotton"
  echo "2. Denim/Jeans"
  echo "3. Silk"
  echo "4. Leather"
  echo "5. Knit/Jersey/Stretch"
  echo "6. Wool/Felt"
  echo "7. Satin"
  echo "8. Linen"
  echo "9. Chiffon/Organza"
  echo "10. Canvas/Upholstery"
  echo
  read -p "Enter the number of your choice: " choice

  case $choice in
    1)
      echo "Suggested Needle: Universal Needle, Size 80/12 or 90/14."
      ;;
    2)
      echo "Suggested Needle: Denim/Jeans Needle, Size 90/14 or 100/16."
      ;;
    3)
      echo "Suggested Needle: Sharp/Microtex Needle, Size 60/8 or 70/10."
      ;;
    4)
      echo "Suggested Needle: Leather Needle, Size 90/14 or 100/16."
      ;;
    5)
      echo "Suggested Needle: Ballpoint or Stretch Needle, Size 75/11 or 90/14."
      ;;
    6)
      echo "Suggested Needle: Universal Needle, Size 80/12 or 90/14."
      ;;
    7)
      echo "Suggested Needle: Sharp/Microtex Needle, Size 70/10 or 80/12."
      ;;
    8)
      echo "Suggested Needle: Universal Needle, Size 80/12."
      ;;
    9)
      echo "Suggested Needle: Sharp/Microtex Needle, Size 60/8."
      ;;
    10)
      echo "Suggested Needle: Heavy Duty Needle, Size 100/16 or 110/18."
      ;;
    *)
      echo "Invalid choice. Please select a number from 1 to 10."
      return
      ;;
  esac
}

# Main loop for user input
while true; do
  echo
  suggest_needle
  read -p "Do you want to check another fabric? (y/n): " choice
  if [[ "$choice" != "y" ]]; then
    echo "Happy sewing! Keep stitching with a smile! 😄"
    break
  fi
done

