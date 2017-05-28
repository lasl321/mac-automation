#!/bin/bash -xev

if [ $# -ne 2 ]; then
    echo 'usage: save-project-files.sh <backup-directory> <project-directory>'
    exit 1
fi

BACKUP_DIRECTORY=$1
PROJECT_DIRECTORY=$2
PROJECT_NAME=$(basename "${PROJECT_DIRECTORY}")

TIMESTAMP=$(date '+%Y-%m-%d-%H-%M-%S')
PROJECT_BACKUP_DIRECTORY=${BACKUP_DIRECTORY}/IntelliJ\ Idea\ Projects/${PROJECT_NAME}
PROJECT_BACKUP_TIMESTAMP_DIRECTORY=${PROJECT_BACKUP_DIRECTORY}/${TIMESTAMP}

mkdir -p "${PROJECT_BACKUP_TIMESTAMP_DIRECTORY}"

pushd "${PROJECT_DIRECTORY}"
cp *.iml "${PROJECT_BACKUP_TIMESTAMP_DIRECTORY}"
cp -R .idea "${PROJECT_BACKUP_TIMESTAMP_DIRECTORY}"
popd

ls -al "$PROJECT_BACKUP_TIMESTAMP_DIRECTORY"

SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PYTHON_SCRIPT="$SCRIPT_DIRECTORY/remove-old-directories.py"
DIRECTORY_LIMIT=120
python3 "$PYTHON_SCRIPT" --parent-directory "$PROJECT_BACKUP_DIRECTORY" --limit ${DIRECTORY_LIMIT}