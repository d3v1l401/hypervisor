#!/bin/bash -e
#
# Copyright (C) 2019 Assured Information Security, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Check for files trying to be commited with +x that shouldn't be
#
index=$(git diff-index --cached --diff-filter=d 'HEAD~1')
while read index;
do
    if [[ ! -z $(echo $index | grep ':100644 100755') ||
          ! -z $(echo $index | grep ':000000 100755') ]]
    then
        path=$(echo $index | awk '{print $NF}')
        name=$(basename -- $path)
        extn="${name##*.}"

        case $extn in
        sh|bat|py|yml) # Add more "recognized" executable file extensions here as needed
            ;;
        *)
            bad="$bad $path"
            ;;
        esac
    fi
done <<< "$index"

if [[ ! -z $bad ]]; then
    for f in $bad
    do
        echo -e "\e[1;91mchk_perms.sh failed\e[0m: file shouldn't be executable: $f"
    done
    exit 1
fi

exit 0
