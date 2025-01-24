#!/usr/bin/env bash
EXEC=$0
NEW_PROJECT=$1

if [ -z "$NEW_PROJECT" ]; then
	echo "$EXEC <new_project_name>"
	exit 1
fi

# move old path to new path
OLD_PROJECT=linapp
DIRS=($(find . -type d -name "*${OLD_PROJECT}*" -not -path './build/*'))

for DIR in ${DIRS[@]}; do
	mv "$DIR" ${DIR/$OLD_PROJECT/$NEW_PROJECT}
done

FILES=($(git ls-files | grep -v $EXEC))
for FILE in ${FILES[@]}; do
	if [ -f $FILE ]; then
	sed -i "s/$OLD_PROJECT/$NEW_PROJECT/g" "$FILE"
		if [[ "$FILE" = *$OLD_PROJECT* ]]; then
			mv "$FILE" "${FILE/$OLD_PROJECT/$NEW_PROJECT}"
		fi
	fi
done

mv $EXEC ${EXEC}.removed
git rm --cached $EXEC
