echo "${CI_MERGE_REQUEST_SOURCE_BRANCH_NAME}", "${CI_MERGE_REQUEST_TARGET_BRANCH_NAME}",
pwd
diff_files=$(git diff --name-only $CI_MERGE_REQUEST_DIFF_BASE_SHA $CI_COMMIT_SHA -- '*.go' | grep -vE "_test\.go$")
echo "diff_files:" "$diff_files"
if [[ -n "$diff_files" ]]; then lines_limit --files  "$diff_files"; else echo "No Go files were modified.";fi
