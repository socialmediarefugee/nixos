{config,pkgs,...}:
{
  environment.systemPackages = with pkgs; [
    binutils
    toybox
    git
    ripgrep
    gnutls
    fd
    sbcl
    sbclPackages.quicklisp-starter
    pkg-config
    sqlite 
    valgrind 
    flamegraph
    massif-visualizer
    strace
    strace-analyzer
    heaptrack
    perf-tools
    hotspot
  ];




}
