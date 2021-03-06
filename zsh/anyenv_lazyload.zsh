#!/usr/bin/env zsh

###############################################################################
# The MIT License (MIT)
#
# Copyright (c) 2016 Seiji AMASHIGE
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
###############################################################################


anyenv_root="${HOME}/.anyenv"
for env in $(/bin/ls $anyenv_root/envs/)
do

    # shims="${shims}$anyenv_root/envs/$env/shims:"
    ENV_ROOT=$(echo ${env} | awk '{print toupper($0)}')_ROOT
    root=$anyenv_root/envs/$env

# xxxenv init しなくてもnvimを起動できるように
# versionファイルがあればpathに追加する
# init on call **env
cat <<EOS
export ${ENV_ROOT}=$root
if [ -e "$root/version" ]; then
    path=($root/versions/\$(cat $root/version)/bin(N-/) \$path)
fi
path=($root/shims(N-/) \$path)
function ${env}() {
    unset -f ${env}
    path=($root/bin(N-/) \$path)
    eval "\$(${env} init - \${SHELL})"
    ${env} \$@
}
EOS

    if [ -e $anyenv_root/envs/${env}/completions/${env}.${SHELL##*/} ];then
        echo "source $anyenv_root/envs/${env}/completions/${env}.${SHELL##*/}"
    fi
done

# Change #L41-42: export -> path
# DELETE: ↓
# echo "export PATH=\""${shims}\${PATH}\"""

