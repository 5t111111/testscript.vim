"if exists('g:loaded_testscript')
"  finish
"endif
"let g:loaded_testscript = 1

let s:save_cpo = &cpo
set cpo&vim

let g:path_to_this = expand("<sfile>:p:h")

function! TestScript()

" Set the path directory contains python module(s)
python << EOF
import vim
import os
import site

plugin_dir = vim.eval('g:path_to_this')
site.addsitedir(os.path.join(plugin_dir, 'lib'))
EOF

python << EOF

import vim

str_list = ['~/test1[SEP]10[SEP]test1 here', \
            '~/test2[SEP]20[SEP]test2 here']
vim.command('botright copen')
vim.command('let &efm="%f[SEP]%l[SEP]%m"')
vim.command('let str_list = %s' % (repr(eval('str_list'))))
vim.command('cgete str_list') 

EOF
endfunction

command! TS :call TestScript()

let &cpo = s:save_cpo
unlet s:save_cpo

