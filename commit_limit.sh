#!/bin/bash

echo "${CI_MERGE_REQUEST_SOURCE_BRANCH_NAME}", "${CI_MERGE_REQUEST_TARGET_BRANCH_NAME}",
pwd
diff_files=$(git diff --name-only $CI_MERGE_REQUEST_DIFF_BASE_SHA $CI_COMMIT_SHA -- '*.go' | grep -vE "_test\.go$")
total_lines_added=0
for file in $diff_files; do
  lines_added=$(git diff --unified=0 $CI_MERGE_REQUEST_DIFF_BASE_SHA $CI_COMMIT_SHA -- $file | grep -e '^+' | grep -v '+++' | grep -v '//' | wc -l)
  total_lines_added=$((total_lines_added + lines_added))
done
echo "Total lines added:" "$total_lines_added"
if [[ $total_lines_added -gt 10 ]]; then
echo "Exceeded maximum commit lines limit";
exit 1;
fi
