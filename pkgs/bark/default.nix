# 当你使用 pkgs.callPackage 函数时，这里的参数会用 Nixpkgs 的软件包和函数自动填充（如果有对应的话）
{
  lib,
  stdenv,
  fetchFromGitHub,
  buildGoModule,
  ...
} @ args:
buildGoModule rec {
  # 指定包名和版本
  pname = "bark-server";
  version = "v2.1.5";

  # # 从 GitHub 下载源代码
  src = fetchFromGitHub {
    owner = "Finb";
    repo = "bark-server";
    # 对应的 commit 或者 tag，注意 fetchFromGitHub 不能跟随 branch！
    rev = "v2.1.5";
    # 下载 git submodules，绝大部分软件包没有这个
    fetchSubmodules = false;
    # 这里的 SHA256 校验码不会算怎么办？先注释掉，然后构建这个软件包，Nix 会报错，并提示你正确的校验码
    sha256 = "sha256-FFoL0HSRhVzFw85+TpxbZFq+R0M/PyGjsejS0ajAuQ0=";
  };

  # 为 go.mod 验证提供 vendorSha256
  # vendorSha256 = "0000000000000000000000000000000000000000000000000000"; # 这是一个假的哈希值
  # vendorSha256 = "sha256-GemXcU5nmMkZSNpuXoRt9EH5PrxMHWLJ56bNYHXOB9I=";
  vendorHash = "sha256-GemXcU5nmMkZSNpuXoRt9EH5PrxMHWLJ56bNYHXOB9I=";

  # 设置 GO111MODULE 环境变量
  preBuild = ''
    export GO111MODULE=on
  '';

  meta = with lib; {
    description = "A description of bark-server";
    homepage = "https://github.com/Finb/bark-server";
    license = licenses.mit;
    maintainers = with maintainers; [
      /*
      维护者列表
      */
    ];
  };
}
