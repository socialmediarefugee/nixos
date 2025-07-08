{pkgs ? import <nixpkgs> {},...}: rec { 

  # Here we would call our own scripts... 
  #aFoo = pkgs.callPackage ./theFoo {};
  #theScript = pkgs.callPackage ./theScriptSource {};
}
