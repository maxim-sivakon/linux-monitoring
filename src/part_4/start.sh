#!/bin/bash
. lib.sh

eval $(cat config)
mycheck $# $column1_background $column1_font_color $column2_background $column2_font_color
setcolors $column1_background $column1_font_color $column2_background $column2_font_color
myprint_report
echo
myprint_colortheme