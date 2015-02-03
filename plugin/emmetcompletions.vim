let g:emmet_completions_plugin_current_directory = resolve(expand('<sfile>:p:h').'/../lib')
python << EOF
import sys,vim
sys.path.append(vim.eval('g:emmet_completions_plugin_current_directory'))
EOF
