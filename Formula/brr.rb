class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.33"
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
      url "https://releases.spacebrr.com/v0.3.33/brr-darwin-arm64"
      sha256 "ec0f4634dca9b7604533f194e6cad9cb6156bcf476eceffb29cf3d03228786c5"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.33/brr-daemon-darwin-arm64"
        sha256 "041635ff4903e02bc92e9d6c734a37900c62d80241d9a761e1cffd07ba9ba47d"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.33/brr-spawn-darwin-arm64"
        sha256 "42a5ba029098da64c3501933ed23496555f73a2e7baa599f98f0172a699d0217"
      end
    else
      url "https://releases.spacebrr.com/v0.3.33/brr-darwin-amd64"
      sha256 "71bf0251e0a341db1cb1a3be9e2fbc1a7de100f1382b4f24d9af0f52b1f0bce0"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.33/brr-daemon-darwin-amd64"
        sha256 "0293c0ee856aa6ada6c126b489ec200f8b9658411785c6ec5b2c5bfeab7892a6"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.33/brr-spawn-darwin-amd64"
        sha256 "e24010075abf2e16770823a2da51f36ff233131b85817e3f8ef0e5171e2700e6"
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
