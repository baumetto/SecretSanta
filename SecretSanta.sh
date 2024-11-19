#! /bin/bash

rm -f *.txt
# ----------------------------------------------------------------
# List of Santas
# ----------------------------------------------------------------
input=$1
if [ $# -ne 1 ]; then
  echo "Error!: there is no list of Santas!"
  exit 1
fi

LIST_NAME=$(find . -iname "${input}*")
LIST_GIFTED=($(cat $LIST_NAME))

LIST_GIFTER=(${LIST_GIFTED[@]})

if [ ${#LIST_GIFTED} -lt 3 ]; then
  echo "Error!: there are less than 3 Santas!"
  echo "You did not think this through, did you, lad?"
  exit 1
fi

# ----------------------------------------------------------------
# List of excluded pairs
# ----------------------------------------------------------------
# Ordering rule: gifter0, gifted0, gifter1, gifted1, etc.
EXCLUDED_PAIR=()

# Exclude from file
for input in $(ls files); do
  gifter=$(echo $input | cut -d. -f1 | awk '{print toupper(substr($1,0,1))tolower(substr($1,2))}')
  gifted=$(head -1 files/$input | awk '{print toupper(substr($1,0,1))tolower(substr($1,2))}')
  EXCLUDED_PAIR+=($gifter $gifted)
  # ----------------------------------------------------------------
  # Check if name exists
  # ----------------------------------------------------------------
  match=0
  for check in ${LIST_GIFTED[@]}; do
    if [ "$check" == "$gifted" ]; then
      match=1
      break
    fi
  done
  if [ $match -eq 0 ]; then
    echo "Error: name in file $gifter does not exist!"
    exit 1
  fi
done

# ----------------------------------------------------------------
# Split pairs
# ----------------------------------------------------------------
EXCLUDED_GIFTED=()
EXCLUDED_GIFTER=()
for ((gifter = 0 ; gifter < ${#EXCLUDED_PAIR[@]} ; gifter=gifter+2)); do
  gifted=$((gifter+1))
  EXCLUDED_GIFTED+=("${EXCLUDED_PAIR[$gifted]}")
  EXCLUDED_GIFTER+=("${EXCLUDED_PAIR[$gifter]}")
  echo "${EXCLUDED_PAIR[$gifter]}, your gift is for ${EXCLUDED_PAIR[$gifted]}" > ${EXCLUDED_PAIR[$gifter]}.txt
done

# ----------------------------------------------------------------
# Update legal gifteds
# ----------------------------------------------------------------
LIST_GIFTED_NEW=()
for gifted in ${LIST_GIFTED[@]}; do
  exclude=0
  for excluded in ${EXCLUDED_GIFTED[@]}; do
    if [ "$gifted" == "$excluded" ]; then
      exclude=1
    fi
  done
  if [ $exclude -eq 0 ]; then
    LIST_GIFTED_NEW+=("$gifted")
  fi
done
LIST_GIFTED=("${LIST_GIFTED_NEW[@]}")

# ----------------------------------------------------------------
# Update legal gifters
# ----------------------------------------------------------------
LIST_GIFTER_NEW=()
for gifter in ${LIST_GIFTER[@]}; do
  exclude=0
  for excluded in ${EXCLUDED_GIFTER[@]}; do
    if [ "$gifter" == "$excluded" ]; then
      exclude=1
    fi
  done
  if [ $exclude -eq 0 ]; then
    LIST_GIFTER_NEW+=("$gifter")
  fi
done
LIST_GIFTER=("${LIST_GIFTER_NEW[@]}")

retry=1
while [ $retry -eq 1 ]; do
  LIST_GIFTER_COPY=(${LIST_GIFTER[@]})
  retry=0
  for gifted in ${LIST_GIFTED[@]}; do
    LIST_GIFTER_DIM=${#LIST_GIFTER_COPY[@]}
    roll=$((RANDOM%LIST_GIFTER_DIM))
    while [ "${LIST_GIFTER_COPY[$roll]}" == "$gifted" ]; do
      roll=$((RANDOM%LIST_GIFTER_DIM))
      if [ $LIST_GIFTER_DIM -eq 1 ]; then
        break
      fi
    done
    gifter=${LIST_GIFTER_COPY[$roll]}
    if [ "$gifted" == "$gifter" ]; then
      echo "Someone picked their own name..."
      echo "Retrying..."
      retry=1
    fi
    if [ $retry -eq 1 ]; then
      break
    fi
    echo "$gifter, your gift is for $gifted" > $gifter.txt
    LIST_GIFTER_NEW=()
    for gifter_old in ${LIST_GIFTER_COPY[@]}; do
      if [ "$gifter_old" != "$gifter" ]; then
        LIST_GIFTER_NEW+=($gifter_old)
      fi
    done
    LIST_GIFTER_COPY=(${LIST_GIFTER_NEW[@]})
  done
done

echo "Secret Santa done!"
