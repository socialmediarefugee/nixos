{config,pkgs,...}:
{
  environment.systemPackages = with pkgs; [
    binutils
    git
    ripgrep
    gnutls
    fd
    sbcl
    sbclPackages.quicklisp-starter
    emacs
    emacsPackages.doom
    emacsPackages.doom-themes
    emacsPackages.doom-modeline
  ];


  environment.variables.PATH = [ "$XDG_CONFIG_HOME/emacs/bin"];

}
