class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.60"
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
      url "https://releases.spacebrr.com/v0.3.60/brr-darwin-arm64"
      sha256 "c2a0f2b675d24412b9333d031814a83239870a3c99a01eacdcd25afdbb14335a"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.60/brr-daemon-darwin-arm64"
        sha256 "62123cd0489991c4bcd63878fd4c814c1f39a234e5d7fe33fd035ac9f3830cef"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.60/brr-spawn-darwin-arm64"
        sha256 "b131926f73d293699fae0aa02f7da58bc588e9c7042b1dcb713fe4d726dfcf0d"
      end
    else
      url "https://releases.spacebrr.com/v0.3.60/brr-darwin-amd64"
      sha256 "b7894cc9b9925ab824af43c5abbdc859e8aa82ea5b937b904a0b4de7793a6318"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.60/brr-daemon-darwin-amd64"
        sha256 "cae09dc3f24735938ee4616e981fbb4cec28a6bdd752e7d4fdd3764d2b768c0d"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.60/brr-spawn-darwin-amd64"
        sha256 "2eba35970747b43677071d8a2302353a6ff0dddaf41ed3d3be14742f87675a25"
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
