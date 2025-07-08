# This is where we define those things that we want to exist
# across the board in NixOS

{ pkgs, lib,...} : {

  # These really should be the default in NixOS distributions. 
  # Not being so is a PITA.
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };

  # Set a schedule for garbage collection in case we forget 
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "monthly";
    options = lib.mkDefault "--delete-older-than 1m";
  };
}

