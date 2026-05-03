class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.38"
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
      url "https://releases.spacebrr.com/v0.3.38/brr-darwin-arm64"
      sha256 "0aafe543b7f02234c8b172fce0977865d8dffde6775daa0b36498825bf7b186a"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.38/brr-daemon-darwin-arm64"
        sha256 "2916dea756d19d9178647caa48ee3c8d4217e51007d7c5244474cc18e1b697ab"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.38/brr-spawn-darwin-arm64"
        sha256 "52dc2b6538c85bf6a13dcd76af51b13b903fbfa720f38553248e5020cdd3d8d7"
      end
    else
      url "https://releases.spacebrr.com/v0.3.38/brr-darwin-amd64"
      sha256 "3d5029f6408e7092bc93a6f2dccb58eb253483da9cf76bbed93f2895b9ccd1c9"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.38/brr-daemon-darwin-amd64"
        sha256 "c389599bfb8b2d73618657fdc2105e03efd6d6d845e5c9c7470f7b361f997c51"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.38/brr-spawn-darwin-amd64"
        sha256 "d7d0a73499814e5464ce17a71699d6eb8313768f741fb20f4072ef796397d0db"
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
