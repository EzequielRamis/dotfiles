{ ... }:

{
  emacsclient =
    "emacsclient -c -a '' -e \"(when (boundp 'persp-names-cache) (+workspace/delete (car (last (+workspace-list-names)))))\"";
}
