{lib,pkgs,...}: {
  environment.systemPackages = with pkgs; [
    xcb-util-cursor
    xorg.libxcb
    xorg.xcbproto
    xorg.xcbutil
    piper-tts
    tmsu
    #tree-sitter
    #tree-sitter-grammars
  ];
}
