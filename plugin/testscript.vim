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
import subprocess

class MyClass(object):
    name = None
    linum = None
    path = None
    content = None

    def __init__(self, line):
        items = line.split(None, 3)
        self.name = items[0]
        self.linum = items[1]
        self.path = items[2]
        self.content = items[3]

plugin_dir = vim.eval('g:path_to_this')
site.addsitedir(os.path.join(plugin_dir, 'lib'))

os.chdir(r'/Users/mubae/Dropbox/Dev/C')
#os.system('cd /Users/mubae/Dropbox/Dev/C')
proc = subprocess.Popen(['/usr/local/bin/global', '-f', 'sample.c'], stdout=subprocess.PIPE)

str_list = []

for line in iter(proc.stdout.readline, ''):
    obj = MyClass(line.rstrip())
    str = '%s[SEP]%s[SEP]%s' % (obj.path, obj.linum, obj.content)
    str_list.append(str)

vim.command('botright copen')
vim.command('let &efm="%f[SEP]%l[SEP]%m"')
vim.command('let l:str_list = %s' % (repr(eval('str_list'))))
vim.command('cgete l:str_list') 

EOF
endfunction

command! TS :call TestScript()

let &cpo = s:save_cpo
unlet s:save_cpo

