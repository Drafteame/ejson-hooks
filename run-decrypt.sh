#!/bin/sh

# Get the list of modified and added files
FILES=$(git diff --cached --name-status | awk '$1 == "M" || $1 == "A" { print $2 }')

# Loop through the files and decrypt if they match the ejson extension
for FILE in $FILES; do
  if [ "${FILE##*.}" = "ejson" ]; then
    # Encrypt the ejson file
    ejson decrypt $FILE
    # Stage the decrypted file
    git add $FILE
  fi
done

# Continue with the commit
exit 0