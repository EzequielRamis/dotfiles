{ lib, ... }:
with builtins;
with lib; {
  filterMapAttrs = pred: f: attrs: filterAttrs pred (mapAttrs f attrs);
  filterMapAttrs' = pred: f: attrs: filterAttrs pred (mapAttrs' f attrs);

  mapFilterAttrs = f: pred: attrs: mapAttrs f (filter pred attrs);
  mapFilterAttrs' = f: pred: attrs: mapAttrs' f (filter pred attrs);
}
