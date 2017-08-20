" -*- mode: vimrc -*-
"vim: ft=vim

function! Layers()
  " Configuration Layers declaration.
  " Add layers with `Layer '+layername'` and add individual packages
  " with `ExtraPlugin 'githubUser/Repo'`.

  Layer '+core/behavior'
  Layer '+core/sensible'
  Layer '+completion/deoplete'
  Layer '+completion/snippets'
  Layer '+checkers/neomake'
  Layer '+nav/buffers'
  Layer '+nav/files'
  Layer '+nav/fuzzy'
  Layer '+nav/quit'
  Layer '+nav/start-screen'
  Layer '+nav/text'
  Layer '+nav/tmux'
  Layer '+nav/windows'
  Layer '+specs/testing'
  Layer '+tools/terminal'
  Layer '+ui/airline'
  Layer '+ui/toggles'
  " Language layers.
  Layer '+lang/elm'
  Layer '+lang/haskell'
  Layer '+lang/javascript'
  Layer '+lang/python'
  Layer '+lang/ruby'
  Layer '+lang/vim'

  " Additional plugins.
  ExtraPlugin 'liuchengxu/space-vim-dark'
endfunction

function! UserInit()
  " This block is called at the very startup of Spaceneovim initialization
  " before layers configuration.

endfunction

function! UserConfig()
  " This block is called after Spaceneovim layers are configured.

  SetTheme 'dark', 'space-vim-dark', 'violet'
endfunction

" Do NOT remove these calls!
call spaceneovim#init()
call Layers()
call UserInit()
call spaceneovim#bootstrap()
call UserConfig()
