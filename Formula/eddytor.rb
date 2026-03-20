class Eddytor < Formula
  desc "Eddytor CLI — query, manage, and explore Delta Lake tables"
  homepage "https://eddytor.com"
  version "1.3.0"
  license "Proprietary"

  on_macos do
    url "https://github.com/eddytor-labs/eddytor-cli/releases/download/v1.3.0/eddytor-1.3.0-aarch64-apple-darwin.tar.gz"
    sha256 "ed7a4e09f43997de026bf518a8c74f458052ddf91d7da945657aceca9497d2e7"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/eddytor-labs/eddytor-cli/releases/download/v1.3.0/eddytor-1.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "73dac81dc42c0a967734d318c0594eabd7c12e9dda5c77dc1566c16d89df8b3c"
    else
      url "https://github.com/eddytor-labs/eddytor-cli/releases/download/v1.3.0/eddytor-1.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dfeb2483e58604a014728deaf69b167d0752dccc3716f386de69d179db86619c"
    end
  end

  def install
    bin.install "eddytor"
  end

  test do
    assert_match "eddytor", shell_output("#{bin}/eddytor --version")
  end
end
