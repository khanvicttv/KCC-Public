#!/bin/bash
# sync-to-public.sh
# Run this after every deploy to content-center
# Copies index.html and sw.js to kcc-public with path updates
#
# Usage: ./sync-to-public.sh
#
# Assumes both repos are cloned side-by-side:
#   ~/repos/content-center/
#   ~/repos/KCC-Public/
#
# Edit these paths if your repos are elsewhere:
SOURCE_DIR="../content-center"
TARGET_DIR="../KCC-Public"

# Check source exists
if [ ! -f "$SOURCE_DIR/index.html" ]; then
  echo "ERROR: Can't find $SOURCE_DIR/index.html"
  echo "Edit SOURCE_DIR in this script to point to your content-center repo."
  exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
  echo "ERROR: Can't find $TARGET_DIR/"
  echo "Edit TARGET_DIR in this script to point to your kcc-public repo."
  exit 1
fi

# Copy and replace paths
echo "Syncing index.html..."
sed 's|/content-center/|/KCC-Public/|g' "$SOURCE_DIR/index.html" > "$TARGET_DIR/index.html"

echo "Syncing sw.js..."
sed 's|/content-center/|/KCC-Public/|g' "$SOURCE_DIR/sw.js" > "$TARGET_DIR/sw.js"

echo ""
echo "Done. Files updated in $TARGET_DIR/"
echo ""
echo "Next steps:"
echo "  cd $TARGET_DIR"
echo "  git add index.html sw.js"
echo "  git commit -m 'sync from content-center'"
echo "  git push"
