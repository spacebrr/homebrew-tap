class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.65"
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
      url "https://releases.spacebrr.com/v0.3.65/brr-darwin-arm64"
      sha256 "fee490ec36cd84aca4b9d806c385fef714f09c654f28aa71b4677641b58459bb"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.65/brr-daemon-darwin-arm64"
        sha256 "ad8cb24753deb0be69b49b2a623d0893a3a7d1cbdf15adc96f1df66cac4f4407"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.65/brr-spawn-darwin-arm64"
        sha256 "3d458198669891486b7430e8ed5f536bc5abe6b66ca93c9ac65b66b42ea2f3f8"
      end
    else
      url "https://releases.spacebrr.com/v0.3.65/brr-darwin-amd64"
      sha256 "f49e49b2e10cb99cf5a4dac5f45c1e4840de8f0f9d78212c56e5bc67060889bc"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.65/brr-daemon-darwin-amd64"
        sha256 "fc195becfbcdc381001ddd57f6e690bc286394184174c3861863c5e4edd69d5f"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.65/brr-spawn-darwin-amd64"
        sha256 "67c5317e89a618faa85f54fa5458ee30614d5d74b40d34d401220fc0335492bf"
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
