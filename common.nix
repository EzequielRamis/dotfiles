inputs:
with (import ./helpers.nix);
{
  imports = map (m: import m inputs) (modulesFrom ./common);
}
