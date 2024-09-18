#!/bin/bash
# do not forget to make the script executable `chmod +x generate_hashes.sh`
# Check if the user provided the amount to generate as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <amount_to_generate>"
  exit 1
fi

# Get the amount of hashes to generate
amount_to_generate=$1

# Generate the requested number of hashes
for (( i=1; i<=amount_to_generate; i++ ))
do
  hash="0x$(openssl rand -hex 32)"
  echo $hash
done
