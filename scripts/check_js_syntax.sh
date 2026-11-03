#!/bin/bash
# JS 语法自检脚本
# 用法: bash check_js_syntax.sh <html文件路径>
# 提取 HTML 中所有内联 <script> 块，逐个执行 node --check 校验语法

HTML_FILE="$1"

if [ -z "$HTML_FILE" ]; then
  echo "用法: bash check_js_syntax.sh <html文件路径>"
  exit 1
fi

if [ ! -f "$HTML_FILE" ]; then
  echo "错误: 文件不存在: $HTML_FILE"
  exit 1
fi

TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT

python3 -c "
import re, sys
html = open('$HTML_FILE', encoding='utf-8').read()
scripts = re.findall(r'<script>(.*?)</script>', html, re.DOTALL)
for i, s in enumerate(scripts):
    open('$TMPDIR/_check_%d.js' % i, 'w', encoding='utf-8').write(s)
    print('Extracted script block %d (%d chars)' % (i, len(s)))
"

PASS=0
FAIL=0

for f in "$TMPDIR"/_check_*.js; do
  if node --check "$f" 2>&1; then
    PASS=$((PASS + 1))
  else
    FAIL=$((FAIL + 1))
    echo "FAIL: $f"
  fi
done

echo ""
echo "结果: $PASS 通过, $FAIL 失败"

if [ $FAIL -gt 0 ]; then
  echo "JS 语法检查未通过，请修复后再交付！"
  exit 1
else
  echo "JS 语法检查通过 ✓"
fi
