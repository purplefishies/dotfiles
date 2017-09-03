#!/bin/bash

# Detect how many colors the terminal supports so source-highlight can
# output in 256.

# Copyright 2012 Xavier-Emmanuel VINCENT
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


colors=$(tput colors)

# /dev/tty doesn't support 256 colors => check $DISPLAY
if [ "${colors}" -eq 256 -a -n "${DISPLAY}" ]
then
	NB="256"
else
	NB=""
fi

suffix=$(echo $1 | perl -pne 's/^.*\.(\S+)/$1/g;')
#echo "${suffix}"

if [[ -f "/usr/share/source-highlight/${suffix}.style" ]] ; then
    stylefile=${suffix}.style
else
    stylefile=esc${NB}.style
fi

source-highlight --outlang-def=esc${NB}.outlang --style-file=${stylefile} -i "$@"

