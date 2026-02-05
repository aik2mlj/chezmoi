#!/bin/sh
pandoc -f gfm -t html | sed 's/<blockquote>/<blockquote style="border-left:2px solid #ccc;padding-left:1em;color:#666;margin:1em 0;">/g'
