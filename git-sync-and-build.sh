#!/bin/bash

## Folders
repo_folder=/path/to/a/folder
publish_folder=/path/to/a/folder
entrypoint_file=./some_script


## Program starting ##
cd $repo_folder


# Fetch get fetches first
echo "Fetching changes from repo..."

git fetch

echo "Fetch done!"

git_diff=$(git diff main origin/main | grep 'diff')

if [ ! -z "$git_diff" ]; then
	echo "Changes found! Pulling changes..."
	
	git pull
	
	echo "Building app..."
	
	# Build app
	dotnet publish -c Release -a arm -o $publish_folder --self-contained
fi

# Run the app
cd $publish_folder

echo "Running the app!"
$entrypoint_file
