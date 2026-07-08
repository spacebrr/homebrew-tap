class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.112"
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
      url "https://releases.spacebrr.com/v0.3.112/brr-darwin-arm64"
      sha256 "940393d05f1566f481da41ea04b489489c5b41a61b3ddd4d9344d9bee883d991"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.112/brr-daemon-darwin-arm64"
        sha256 "aed2ee7435406fa37f79fd4da419115cac2a58feb38676581d8f083edc9b4a82"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.112/brr-spawn-darwin-arm64"
        sha256 "f991dfcc1ab27e2f7d3b327deea15c23e95d81173f26cf17dde8fc2a7957564a"
      end
    else
      url "https://releases.spacebrr.com/v0.3.112/brr-darwin-amd64"
      sha256 "f232bec04b006c471d6da262b9a2cdf6a61e6be6cf13051cc50ca43ced790198"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.112/brr-daemon-darwin-amd64"
        sha256 "39c34ba58014bedff6c6da3593a3c36ed81a90affa9b98f4042b879902cb7268"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.112/brr-spawn-darwin-amd64"
        sha256 "80a4838eba08e4a5f5e22efa5e7ff77765c968116709923dd3ea2b6f3dc19c50"
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
