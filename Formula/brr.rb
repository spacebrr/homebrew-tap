class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.40"
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
      url "https://releases.spacebrr.com/v0.3.40/brr-darwin-arm64"
      sha256 "3a4fa78c372934a39cb81fa0748b1dbfcbab8fc2e28c63134257883487922721"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.40/brr-daemon-darwin-arm64"
        sha256 "9a1bd21fdaefa7f1e3648094b8fd12baac751d8257ff882dd939002677d1d484"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.40/brr-spawn-darwin-arm64"
        sha256 "4efa0c9160cc3d1fcd01930923a62823f25d2a718c41ff96ec53dd9b4b5e218a"
      end
    else
      url "https://releases.spacebrr.com/v0.3.40/brr-darwin-amd64"
      sha256 "2ef6414aa5a783a52a53d192ef2377beb97c38c61445a3e489a99a50feb44ace"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.40/brr-daemon-darwin-amd64"
        sha256 "08d735f4d4da39d1d1a29cf2c151f7875caa9399d6a63e577ec9c95207843d6a"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.40/brr-spawn-darwin-amd64"
        sha256 "0f3201749a9ff27c06b9fde4a446595f3ad9a4cc3e0e2ed1d14b2cbe74d73bae"
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
