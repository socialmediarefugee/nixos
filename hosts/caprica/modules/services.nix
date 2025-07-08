{lib,pkgs,...}: {
  # Keep services here.
  services = {
    speechd = {
      enable = true;
    };
  };
}
