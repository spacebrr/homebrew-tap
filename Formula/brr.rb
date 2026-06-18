class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.81"
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
      url "https://releases.spacebrr.com/v0.3.81/brr-darwin-arm64"
      sha256 "26f81de43fbacaffad9f8d8bdbecb0977772c6e1be3e4c14ac4ec1bfb33f297e"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.81/brr-daemon-darwin-arm64"
        sha256 "568e886c808d5247d93430da57a57784d0098953246269ef4a49472ae0b290fb"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.81/brr-spawn-darwin-arm64"
        sha256 "85d8101cab2f151cb5f8bd9899bf852c2e059691d3af4d44252144ce784b9cfd"
      end
    else
      url "https://releases.spacebrr.com/v0.3.81/brr-darwin-amd64"
      sha256 "94aec9907bb1cf6429bd8deceeff5700246fe12e46fa46f0ce8f910f52b193a5"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.81/brr-daemon-darwin-amd64"
        sha256 "27ae915d8fa097727f3b6cd7bab78c9b4258fc6afd35bbaa6a6b31d9f385389f"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.81/brr-spawn-darwin-amd64"
        sha256 "7cae9f933cc10b092cbe03df75867be9edb7f7f44da69cc519fb887d7dbadce6"
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
