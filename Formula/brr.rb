class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.34"
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
      url "https://releases.spacebrr.com/v0.3.34/brr-darwin-arm64"
      sha256 "073a3b7767a6ed7aa4af1f1f1a2bd1c8f68938213782bbc4931e566db8b9699c"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.34/brr-daemon-darwin-arm64"
        sha256 "9cf3ab90a6993814249fbe0fd5242b78f1f8da2bd6bc348bec730371db84825a"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.34/brr-spawn-darwin-arm64"
        sha256 "90abf871aa375950e3183faf7f804234ce9bfb914a1b2b3f7c3c1d6339bd001b"
      end
    else
      url "https://releases.spacebrr.com/v0.3.34/brr-darwin-amd64"
      sha256 "628f614d44cfc7b388507e418918008d2c265b9413bda079868ef38b9b98a5d6"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.34/brr-daemon-darwin-amd64"
        sha256 "bdd735480cf24f80b1ef7dd7e10e0ae9fb49bdcf81557759e1a2005810a7401e"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.34/brr-spawn-darwin-amd64"
        sha256 "181b3df3891c45410db3ae0165d05ac5a7cc2e335159e2b7f8145c3bf1465e96"
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
