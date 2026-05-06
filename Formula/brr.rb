class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.54"
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
      url "https://releases.spacebrr.com/v0.3.54/brr-darwin-arm64"
      sha256 "fffe2b813ec59e0e61f13952ae97dd6f7b871159b8cbd6938e4cc9c9af1db82b"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.54/brr-daemon-darwin-arm64"
        sha256 "95f6e62dcdd812acfce5b0a5658809d9ff6c37c8a9390ce8e1be2998e7f7a0e3"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.54/brr-spawn-darwin-arm64"
        sha256 "306454d07d4aebb8ad3fa09dce2a594bc6dcd7fdd96fd3d94aa173055acfcf64"
      end
    else
      url "https://releases.spacebrr.com/v0.3.54/brr-darwin-amd64"
      sha256 "5eaacd364d1699cd017a4996ce197001ae1952abd2265f13176ed6d3361a4df8"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.54/brr-daemon-darwin-amd64"
        sha256 "d67d032be18822d07ab36a489dde5bb4cd4efb0d8abce4f764653795b4a9c11a"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.54/brr-spawn-darwin-amd64"
        sha256 "291602e4008772c9de3ac17135683b1b98920988feb926298bd8b79fb5f28af1"
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
