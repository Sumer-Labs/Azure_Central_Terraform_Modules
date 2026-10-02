#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo "Terraform Change Detection"
echo "======================================"

# Get files changed in the current PR
CHANGED_FILES=$(git diff --name-only \
  "${BASE_SHA}" \
  "${HEAD_SHA}")

echo ""
echo "Changed files:"
echo "$CHANGED_FILES"
echo ""

TERRAFORM_CHANGED=false

while IFS= read -r file; do

  # Ignore empty lines
  [[ -z "$file" ]] && continue

  case "$file" in
    *.tf|*.tfvars|*.tf.json|*.tftest.hcl)
      echo "Terraform file detected: $file"
      TERRAFORM_CHANGED=true
      ;;
  esac

done <<< "$CHANGED_FILES"

echo ""
echo "======================================"
echo "Terraform changed: $TERRAFORM_CHANGED"
echo "======================================"

# GitHub Actions output
echo "terraform_changed=$TERRAFORM_CHANGED" >> "$GITHUB_OUTPUT"