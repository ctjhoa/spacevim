" -*- mode: vimrc -*-
"vim: ft=vim

function! Layers()
  " Configuration Layers declaration.
  " Add layers with `Layer '+layername'` and add individual packages
  " with `ExtraPlugin 'githubUser/Repo'`.

  Layer '+core/behavior'
  Layer '+nav/buffers'
  Layer '+nav/files'
  Layer '+nav/quit'
  Layer '+nav/windows'
  Layer '+nav/start-screen'
  Layer '+nav/text'
  Layer '+checkers/neomake'
  Layer '+completion/deoplete'
  Layer '+tools/terminal'
  Layer '+ui/airline'
  Layer '+ui/toggles'

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
