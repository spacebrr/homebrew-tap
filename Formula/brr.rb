class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.62"
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
      url "https://releases.spacebrr.com/v0.3.62/brr-darwin-arm64"
      sha256 "74243156c8e02aa978a38614d3c6c28cb48d700f7ccea1ba1b5e7faa6d2aa6f8"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.62/brr-daemon-darwin-arm64"
        sha256 "ab2faaa73d1fedb41c626d14f28a5fe9c7796d4110e270bb92108c352c20fbcd"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.62/brr-spawn-darwin-arm64"
        sha256 "1bef23f7aefe3125145a01fcc7804f81c714c9bfc7ce1027661c619316e13717"
      end
    else
      url "https://releases.spacebrr.com/v0.3.62/brr-darwin-amd64"
      sha256 "7449e05f03eb4eeb66e94ebf98d33e34bfecc845b25dfd617676a750fc53fe63"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.62/brr-daemon-darwin-amd64"
        sha256 "7f4b2f1eb46991aadcddaf731f1ffa6c99b0d96efbf72119df9e893e4ca726b0"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.62/brr-spawn-darwin-amd64"
        sha256 "dd18357411c5aa3f1a8e1d3fb08906208d3cfb0689b25e0e154afd9d552b3a37"
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
