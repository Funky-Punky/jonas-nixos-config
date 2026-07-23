{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    davinci-resolve
    shotcut
  ];
  
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };
}