class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.75"
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
      url "https://releases.spacebrr.com/v0.3.75/brr-darwin-arm64"
      sha256 "d63e86497366e78569cf0ea92c7a8cfdd4eac3cf81636687f6b692607c265b04"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.75/brr-daemon-darwin-arm64"
        sha256 "a560fc4d7ace85140cb8052c63b8d20926509b9cd0c230d4f266bef4a1142b20"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.75/brr-spawn-darwin-arm64"
        sha256 "50827c427c7959722b33f928e3b6e783102c87c553b5e09bb760ee4e2ff6e381"
      end
    else
      url "https://releases.spacebrr.com/v0.3.75/brr-darwin-amd64"
      sha256 "54b3a2ad1bc4cfc54cfc07c0a6890469e76d4ddf3a8826a674b8872b0b30222f"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.75/brr-daemon-darwin-amd64"
        sha256 "efdc98db423919e210fc2ea28b61ba131bd492a609cae364f4e393b5301c14d1"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.75/brr-spawn-darwin-amd64"
        sha256 "88e62fa9bbaeb6d2e2dc809c561db60f0222bee7027894d917bf48519be58f49"
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
