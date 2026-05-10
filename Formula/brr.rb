class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.56"
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
      url "https://releases.spacebrr.com/v0.3.56/brr-darwin-arm64"
      sha256 "54eafd252549e5d0f1951fbb02aac49579d9f6f630914dae7b6e3de6d4a48c23"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.56/brr-daemon-darwin-arm64"
        sha256 "b451b748ecbea1d7bbc7150bc45e48362d35478223e2df3d201a14042f131736"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.56/brr-spawn-darwin-arm64"
        sha256 "4de4afc9b2f4d7e064cf2751febba954142af6d67d2f5b3b9a88675a8411c9d1"
      end
    else
      url "https://releases.spacebrr.com/v0.3.56/brr-darwin-amd64"
      sha256 "ca1ff0584c3ae575fac30e786fcd5e7f28be1e469e74638707a98dde7f2a326c"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.56/brr-daemon-darwin-amd64"
        sha256 "2246d5d8c695f72253c4d149dfbc8de9e2a5d9e2cd929aac0cef02b0690f5890"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.56/brr-spawn-darwin-amd64"
        sha256 "07cf3c05c72a317981e485b67d4f6fd3ed79463ea612a603202d597bcd96115d"
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
