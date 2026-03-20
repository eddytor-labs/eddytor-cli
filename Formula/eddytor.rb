class Eddytor < Formula
  desc "Eddytor CLI — query, manage, and explore Delta Lake tables"
  homepage "https://eddytor.com"
  version "1.3.0"
  license "Proprietary"

  on_macos do
    url "https://github.com/eddytor-labs/eddytor-cli/releases/download/v1.3.0/eddytor-1.3.0-aarch64-apple-darwin.tar.gz"
    sha256 "a5e212cb1e83ca9ea7f205f50f013a9589e10ab4cdc91826b115a621ebc63149"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/eddytor-labs/eddytor-cli/releases/download/v1.3.0/eddytor-1.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "61d63e69595eb7ad3fbe505b8b22e7d990d27aa1a48c099b5430e7ca9021a426"
    else
      url "https://github.com/eddytor-labs/eddytor-cli/releases/download/v1.3.0/eddytor-1.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8bf87a0b4251e3f1583b994b7c282c5440cc33e4548f327c09c8e32f2b44bdeb"
    end
  end

  def install
    bin.install "eddytor"
  end

  test do
    assert_match "eddytor", shell_output("#{bin}/eddytor --version")
  end
end
