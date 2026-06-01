class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.67"
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
      url "https://releases.spacebrr.com/v0.3.67/brr-darwin-arm64"
      sha256 "20409af3578d49d4b5981c8dd599734aba465f29df186f99c0e0a0fdb8fa82dc"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.67/brr-daemon-darwin-arm64"
        sha256 "51aa5493395967112c89254cf731ece46c0003e910468f08c5a74721eae6814a"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.67/brr-spawn-darwin-arm64"
        sha256 "53889662a8aaef85252c80e32f53d813fbf0ffbc8755da6ad8a0456b68c1a3a3"
      end
    else
      url "https://releases.spacebrr.com/v0.3.67/brr-darwin-amd64"
      sha256 "e5a0c4cf817562be2bc2fb8a0d04dac233093d365df450f6fa8bc66e020920c7"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.67/brr-daemon-darwin-amd64"
        sha256 "4521d6238875dae61a6e17f48a648b311bf960c3179a0f42fd3020339e2587c4"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.67/brr-spawn-darwin-amd64"
        sha256 "82dad8c820b3eab82bf5b8fa89f7c9fece129fea8bd99f57c0f015fe84bc0ff2"
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
