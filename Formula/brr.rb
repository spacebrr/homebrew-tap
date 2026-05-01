class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.32"
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
      url "https://releases.spacebrr.com/v0.3.32/brr-darwin-arm64"
      sha256 "036887335949b0dd09b267777d8c868db28506b71ecf89d01f416c1a96b126aa"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.32/brr-daemon-darwin-arm64"
        sha256 "cf5aa932b8d17fd66500a3aeebf4e15119059210b234f1106e123526d52923b0"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.32/brr-spawn-darwin-arm64"
        sha256 "a802b11b1e860eddb1678859635dc5b4119bd4cb446589b41bb6e82386e0d0db"
      end
    else
      url "https://releases.spacebrr.com/v0.3.32/brr-darwin-amd64"
      sha256 "19561218068b71bc1b896ae723858f5cdc251b264d93dcf0438f51b55891a843"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.32/brr-daemon-darwin-amd64"
        sha256 "2fc4509caa20659e7eda7f8b79926bfc317d762fde7ef23ad54642e73ce327eb"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.32/brr-spawn-darwin-amd64"
        sha256 "4e1c85a9182ab4be43701190c8fba4a0fe48023c7274ce1e9e6213bcea4a0e0e"
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
