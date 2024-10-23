{
  # Add your NixOS modules here
  #
  # my-module = ./my-module;
  # imports = [
  #   # 其他导入...
  #   ./bark-service.nix
  # ];
  barkServer = import ./bark-service.nix;
}
