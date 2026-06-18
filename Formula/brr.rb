class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.79"
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
      url "https://releases.spacebrr.com/v0.3.79/brr-darwin-arm64"
      sha256 "5140b4f45dd419208c116b486b1eb2456812155cd18d35d3983000e949634849"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.79/brr-daemon-darwin-arm64"
        sha256 "d6fa7d06f60ebadb084a4b6777a8fcf71f14bb9bd83f4b92519f45e8caa04ba7"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.79/brr-spawn-darwin-arm64"
        sha256 "ac277dcdee9039a37c5af3dbe378f2c0af2f415d6e0c5cfedb6e812ca4e5d231"
      end
    else
      url "https://releases.spacebrr.com/v0.3.79/brr-darwin-amd64"
      sha256 "90ff1c22dfe594e858159f66315780a83ff3dae5357d988b0b37a000346e0601"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.79/brr-daemon-darwin-amd64"
        sha256 "e2f9b379d261f691fb69fad2a23d5de71b4205aad00f2925d8becfdde6a18c09"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.79/brr-spawn-darwin-amd64"
        sha256 "5c0e33a74d6d087a5276e9cb6fc1955263a6a0ed771245f9a9a602f9d60fd59f"
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
