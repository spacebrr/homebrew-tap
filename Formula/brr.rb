class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.45"
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
      url "https://releases.spacebrr.com/v0.3.45/brr-darwin-arm64"
      sha256 "a200a2cf35675ab345b2bfff8b96c61362e7ed56df027073e78c17077ddc358d"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.45/brr-daemon-darwin-arm64"
        sha256 "ad517dbc4221926c587ed983c8834d937ce1cc27e7b7c78f6db60bd41a540ebc"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.45/brr-spawn-darwin-arm64"
        sha256 "ec32326824ec6daabb8207e3c3d0785e6bcc1458846b2faa492dbda5f89fd9a6"
      end
    else
      url "https://releases.spacebrr.com/v0.3.45/brr-darwin-amd64"
      sha256 "7f5ac41ad4d4b2cdc335284d660c5f9d72b162418a2046f13305956d7950bd67"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.45/brr-daemon-darwin-amd64"
        sha256 "0642c5ec30848fcab004830cfe84a823086093595a3c6302c1528d518f3db5d6"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.45/brr-spawn-darwin-amd64"
        sha256 "786ea9d6251623458fc7278bbe58fc9ec9a7a217263d0c3babc4a58e275cf6cc"
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
