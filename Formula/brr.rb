class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.120"
  license :cannot_represent

  service do
    run [opt_bin/"brr-daemon"]
    keep_alive true
    log_path "/tmp/brr-daemon.log"
    error_log_path "/tmp/brr-daemon.log"
    environment_variables PATH: std_service_path_env
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://releases.spacebrr.com/v0.3.120/brr-darwin-arm64"
      sha256 "a4f6407c950a381ae054ba82825e48c82694c8ad45b5ca8d2b0822c3dcce2fd2"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.120/brr-daemon-darwin-arm64"
        sha256 "d6012a001cfe89ef6de9844ba433bd2de4f53bfa1d8186698b07f7d756689f88"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.120/brr-spawn-darwin-arm64"
        sha256 "7af498ad0cb977990c078292d7d0e589e9b4f471eed8c8bede198a65be882e06"
      end
    else
      url "https://releases.spacebrr.com/v0.3.120/brr-darwin-amd64"
      sha256 "bd6456674a051134df400ad2ffc7bbd35ed15884b703df7ca0454aca26ede988"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.120/brr-daemon-darwin-amd64"
        sha256 "ed06e0b7a16fab89c27237bf53e6c1371c8bd642dac202ee701c5479b04feec0"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.120/brr-spawn-darwin-amd64"
        sha256 "5cee677fd4a82c86f39c7ffd03e936edfadf51fa0c9780d5c791ea6c52359ccd"
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
