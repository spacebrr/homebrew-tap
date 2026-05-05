class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.51"
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
      url "https://releases.spacebrr.com/v0.3.51/brr-darwin-arm64"
      sha256 "aa513d59e2b7f5c3032aac0ac59b8a3dcb82051d2e8e5a65af0171592b7ebf7d"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.51/brr-daemon-darwin-arm64"
        sha256 "722c5edd71e65a665f54e84a19db7efdb9808ac65749566330ed87980605bd6f"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.51/brr-spawn-darwin-arm64"
        sha256 "1db1cadeb22682b476b205da29615cc7d90eea0d255fc860292b90557f7d24d0"
      end
    else
      url "https://releases.spacebrr.com/v0.3.51/brr-darwin-amd64"
      sha256 "7b4b682e11926a0ef798a4a754ddbff34a4da0242eea811af9f11c243f91a685"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.51/brr-daemon-darwin-amd64"
        sha256 "2dd446c7413a9de226444f275a5d4e494b2b8582ebb86bba288080db811210c4"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.51/brr-spawn-darwin-amd64"
        sha256 "5d94a78c92395aa4cf0584288a187f5363bc18319ceef7d7895662a1b2202d60"
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
