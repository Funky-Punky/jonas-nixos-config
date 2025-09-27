{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    bat
  ]


}