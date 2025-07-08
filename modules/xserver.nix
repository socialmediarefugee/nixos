{lib,...}:
{

 qt.platformTheme = "kde";

 services.xserver = {
   enable = true;
   videoDrivers = ["nvidia"];
   autorun = true;
   xkb = {
     layout = "us";
     variant = "";
   };
 };

 services.desktopManager = {
   plasma6.enable = true;
 };

 services.displayManager = {
  enable = true;
  #plasma6.enable = true;
  sddm = {
    enable = true;
    wayland = {
      enable = true;
    };
  };
 };

}
