class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.109"
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
      url "https://releases.spacebrr.com/v0.3.109/brr-darwin-arm64"
      sha256 "9442cc6b6c997bf49e7f22f9a516f58ec718b84a86a1686a8e1b4591be3b5105"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.109/brr-daemon-darwin-arm64"
        sha256 "bbe72e5b3c9a68752ee1d29b82c24141fa6506a1f1a4190c689a8162f3bea2c1"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.109/brr-spawn-darwin-arm64"
        sha256 "73bcdc7a8a2a403ea104844ada7d4a72c118e049a316f2923682bbdce91f9500"
      end
    else
      url "https://releases.spacebrr.com/v0.3.109/brr-darwin-amd64"
      sha256 "0de7cfc00349d9768b388cfb16ccc8568669b9615e4849042f6881a25f149991"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.109/brr-daemon-darwin-amd64"
        sha256 "be03c710ab3c5b965a4a83eeea40f4eadfe32d445c2ada2c6fac95c7980c472f"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.109/brr-spawn-darwin-amd64"
        sha256 "e4fb1087e88fafe52d3fa63a7b552faf320a1b42f94b6916d2fb71e068a460c5"
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
