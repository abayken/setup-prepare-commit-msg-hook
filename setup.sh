#!/bin/bash

HOOKS_DIR=".git/hooks"
HOOK_FILE="prepare-commit-msg"
SCRIPT_CONTENT="#!/bin/bash

BRANCH_NAME=\$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
if [ ! -z \"\$BRANCH_NAME\" ] && [ \"\$BRANCH_NAME\" != \"HEAD\" ] && [ \"\$SKIP_PREPARE_COMMIT_MSG\" != 1 ]; then

  PREFIX_PATTERN='[A-Z]+-[0-9]+'

  [[ \$BRANCH_NAME =~ \$PREFIX_PATTERN ]]

  PREFIX=\${BASH_REMATCH[0]}

  PREFIX_IN_COMMIT=\$(grep -c \$PREFIX \$1)

  if [[ -n \"\$PREFIX\" ]] && ! [[ \$PREFIX_IN_COMMIT -ge 1 ]]; then
    sed -i.bak -e \"1s~^~\$PREFIX ~\" \$1
  fi
fi"

echo "$SCRIPT_CONTENT" > "$HOOKS_DIR/$HOOK_FILE"
chmod +x "$HOOKS_DIR/$HOOK_FILE"
echo "Congrats"
