#!/usr/bin/env bash
# pages/ 以下のファイルへのリンクのみを持つ index.html を生成する
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PAGES_DIR="${ROOT_DIR}/pages"
OUTPUT_FILE="${ROOT_DIR}/index.html"

if [ ! -d "${PAGES_DIR}" ]; then
  echo "pages ディレクトリが見つかりません: ${PAGES_DIR}" >&2
  exit 1
fi

{
  echo "<!DOCTYPE html>"
  echo "<html lang=\"ja\">"
  echo "<head>"
  echo "  <meta charset=\"UTF-8\">"
  echo "  <title>Index</title>"
  echo "</head>"
  echo "<body>"
  echo "  <ul>"

  find "${PAGES_DIR}" -type f | LC_ALL=C sort | while IFS= read -r file; do
    rel_path="${file#"${ROOT_DIR}"/}"
    echo "    <li><a href=\"${rel_path}\">${rel_path}</a></li>"
  done

  echo "  </ul>"
  echo "</body>"
  echo "</html>"
} > "${OUTPUT_FILE}"

echo "生成しました: ${OUTPUT_FILE}"
