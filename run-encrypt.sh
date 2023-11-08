#!/bin/sh

# Define the ejson command
EJSON_CMD="ejson"

# Get the list of modified and added files
FILES=$(git diff --cached --name-status | awk '$1 == "M" || $1 == "A" { print $2 }')

# Loop through the files and encrypt if they match the ejson extension
for FILE in $FILES; do
  if [ "${FILE##*.}" = "ejson" ]; then
    # Encrypt the ejson file
    $EJSON_CMD encrypt "$FILE"
    # Stage the encrypted file
    git add "$FILE"
  fi
done

# Continue with the commit
exit 0