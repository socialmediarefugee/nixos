{ config, pkgs, ... }:

{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sunshine";
  home.homeDirectory = "/home/sunshine";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.bat
    pkgs.lsd
    pkgs.ripgrep
    pkgs.fzf
    pkgs.fd
    pkgs.ankacoder
    pkgs.alegreya
    pkgs.aleo-fonts
    pkgs.eunomia
    pkgs.f1_8
    pkgs.f5_6
    pkgs.fa_1
    pkgs.fantasque-sans-mono
    pkgs.ferrum
    pkgs.fragment-mono
    pkgs.nerd-fonts._3270
    pkgs.nerd-fonts.martian-mono
    pkgs.nerd-fonts.monofur
    pkgs.nerd-fonts.monaspace
    pkgs.nerd-fonts.open-dyslexic
    pkgs.nerd-fonts.proggy-clean-tt
    pkgs.nerd-fonts.recursive-mono
    pkgs.neovide
    pkgs.vimPlugins.nvchad
    pkgs.tree-sitter
  ];

  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/sunshine/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "neovide";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
