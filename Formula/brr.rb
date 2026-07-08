class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.111"
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
      url "https://releases.spacebrr.com/v0.3.111/brr-darwin-arm64"
      sha256 "0d79a21a14f207f8938c43b5f116f3fd87d3af93f69a77a3e8e62a028ef7519b"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.111/brr-daemon-darwin-arm64"
        sha256 "159b47535a21296dd94794bcdcfdd56b5b1f08fdc347136a3ef6999bd31a7d19"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.111/brr-spawn-darwin-arm64"
        sha256 "f560412d890d10e3a08da86e0b97c5c124deb166ee34227e31b4dd983c12de11"
      end
    else
      url "https://releases.spacebrr.com/v0.3.111/brr-darwin-amd64"
      sha256 "d639b025b96738441a04c194cd002f33ab7412cd3d35420920961dda7927c07f"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.111/brr-daemon-darwin-amd64"
        sha256 "03d01ed75b500bf9582fec4e8a52fa18deb57053bcadcb5e6e3338ad3bc787e6"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.111/brr-spawn-darwin-amd64"
        sha256 "3b762644a7b022dfcd0545019992d41e16b0fc0f982dfb7d6857b52ca4fad79c"
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
