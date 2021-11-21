with builtins;
{
  modulesFrom = dir: filter (d: pathExists "${d}/default.nix")
        (map (m: dir + "/${m}")
          (attrNames (readDir dir)));
}
