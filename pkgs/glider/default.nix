{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "glider";
  version = "0.16.4";

  src = fetchFromGitHub {
    owner = "nadoo";
    repo = "glider";
    rev = "v${version}";
    hash = "sha256-LrIHdI1/55llENjDgFJxh2KKsJf/tLT3P9L9jhLhfS0=";
  };

  vendorHash = "sha256-v/HJUah+QC34hcf9y5yRSFO8OTkqD2wzdOH/wIXrKoA=";

  ldflags = [ "-s" "-w" ];

  meta = {
    description = "Glider is a forward proxy with multiple protocols support, and also a dns/dhcp server with ipset management features(like dnsmasq";
    homepage = "https://github.com/nadoo/glider";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "glider";
  };
}
