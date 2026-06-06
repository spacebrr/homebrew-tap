class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.76"
  license :cannot_represent

  service do
    run [opt_bin/"brr-daemon"]
    keep_alive true
    log_path "#{Dir.home}/.space/logs/daemon.log"
    error_log_path "#{Dir.home}/.space/logs/daemon.log"
    environment_variables PATH: std_service_path_env
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://releases.spacebrr.com/v0.3.76/brr-darwin-arm64"
      sha256 "936b6908b2c1d9d0ed5f3d62aecc1607a34f9c44f6278f564eb2d88a77a39140"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.76/brr-daemon-darwin-arm64"
        sha256 "b56b0a773f80ccd4136e01fc5ed24810fef1480ae3f708a66d8bbb05b440f992"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.76/brr-spawn-darwin-arm64"
        sha256 "6954f49daf25df03cd7a50e0e6ec4732c8f8a90981925f6623689045735478ce"
      end
    else
      url "https://releases.spacebrr.com/v0.3.76/brr-darwin-amd64"
      sha256 "c05efc22923959bcee8285c2ea4bf752cefd017681f7ab947f196d5c99bc60f0"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.76/brr-daemon-darwin-amd64"
        sha256 "f90016521b07ab52a498d530604c5bb9f06976b85366f9050c43b935f71ae880"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.76/brr-spawn-darwin-amd64"
        sha256 "e4e7ba8e8be74c99b2d5018408ab3c5b69d25cc838125505a13d2dedc2f66da2"
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
