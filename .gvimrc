set vb
set t_vb="
  if has("gui_macvim")
    macmenu &File.New\ Tab key=<nop>
  endif
