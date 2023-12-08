#!/bin/sh

# Get the list of modified and added files
FILES=$(git diff --cached --name-status | awk '$1 == "M" || $1 == "A" { print $2 }')
EXIT_CODE=0

# Loop through the files and encrypt if they match the ejson extension
for FILE in $FILES; do
  if [ "${FILE##*.}" = "ejson" ]; then
    # Encrypt the ejson file
    ejson_output=$(ejson encrypt $FILE 2>&1)

    # check if ejson exit code is different from 0
    if [ $? -ne 0 ]; then
        echo "Error encoding file $FILE: $ejson_output"
        EXIT_CODE=1
    else
      # Stage the decrypted file
      git add $FILE
    fi
  fi
done

# Continue with the commit
exit $EXIT_CODE