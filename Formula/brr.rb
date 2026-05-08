class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.55"
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
      url "https://releases.spacebrr.com/v0.3.55/brr-darwin-arm64"
      sha256 "f9e423a60ca07c273dec33f197384c8bb1cce66dd5cbb83009ac1214a4f250e5"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.55/brr-daemon-darwin-arm64"
        sha256 "0c263059c90d3cb09187c00ad5da860ecf47b4ce4602d4b0a21065996297b67c"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.55/brr-spawn-darwin-arm64"
        sha256 "d70d5304047cd44e52fc05b51683a9e311d9c43e3a81ad24da65a261a8f1fd37"
      end
    else
      url "https://releases.spacebrr.com/v0.3.55/brr-darwin-amd64"
      sha256 "b96b583879aff35f5d67ab5351d1e78ecbc36b183227df0649d5e8621e117e0b"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.55/brr-daemon-darwin-amd64"
        sha256 "b3b3037ba92be02ea46430c128058b3cb71a340a1dc3ec8996591227a082447b"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.55/brr-spawn-darwin-amd64"
        sha256 "863acd5aa75325d4e56fcf6a0376be1d0816a13c071c887cbbe91877d525e190"
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
