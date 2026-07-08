class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.113"
  license :cannot_represent

  service do
    run [opt_bin/"brr-daemon"]
    keep_alive true
    log_path "/tmp/brr-daemon.log"
    error_log_path "/tmp/brr-daemon.log"
    environment_variables PATH: std_service_path_env
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://releases.spacebrr.com/v0.3.113/brr-darwin-arm64"
      sha256 "1682b1d60a7649796219efd7a9ce3968aa1baa4c4a63b998dcd806f3ba9e6f81"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.113/brr-daemon-darwin-arm64"
        sha256 "e2b2689f7c9be116744121709aaa382fea0eeb169ed27855f0cd335243e25d63"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.113/brr-spawn-darwin-arm64"
        sha256 "4602dedc7e4a81d6d79714850629631d226a8c826ac62e258e28257da2263cc8"
      end
    else
      url "https://releases.spacebrr.com/v0.3.113/brr-darwin-amd64"
      sha256 "4a5e6c2277deb52878d44b1163653cdc434021f079d15fd513eb22eac344fbb4"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.113/brr-daemon-darwin-amd64"
        sha256 "91ae497fd948fdc4f6429089fd8f2ca0d87cd392bfc80c3641856721defe3f14"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.113/brr-spawn-darwin-amd64"
        sha256 "8670c1b64f467c4e3a006d4c222b64dfab1df4db67b420922e800eaee3cd2c25"
      end
    end
  end

  def install
    bin.install Dir.glob("brr-*").first || "brr" => "brr"
    resource("brr-daemon").stage { bin.install Dir.glob("brr-*").first || "brr-daemon" => "brr-daemon" }
    resource("brr-spawn").stage { bin.install Dir.glob("brr-*").first || "brr-spawn" => "brr-spawn" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/brr version")
  end
end
