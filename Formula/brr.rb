class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.61"
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
      url "https://releases.spacebrr.com/v0.3.61/brr-darwin-arm64"
      sha256 "ce6ac62d4c1e9f59f0f23448286a91c4f48215afe3d2e9b608358b4328823580"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.61/brr-daemon-darwin-arm64"
        sha256 "2946a4146aa668d0c35fd310bc723da80174ac648829c595d65aadc7a1a5b7ef"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.61/brr-spawn-darwin-arm64"
        sha256 "17d04000934f9f08a09a03440acf7ca09ecbb47b30d4edf67fc15340dc910760"
      end
    else
      url "https://releases.spacebrr.com/v0.3.61/brr-darwin-amd64"
      sha256 "4f7493a07ae154a0b6b780df22974f99e50aa1d209388f0f3f9b9a5bff00146f"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.61/brr-daemon-darwin-amd64"
        sha256 "fdce068d45af668e790e0e2d9a7d323b945045331d7445caa5b03c7fb3093283"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.61/brr-spawn-darwin-amd64"
        sha256 "049660b9db52c89f08fe2dc9f8864a345b25309c1cd3e0dc18b3a3803976a039"
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
