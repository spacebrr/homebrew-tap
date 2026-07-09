class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.117"
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
      url "https://releases.spacebrr.com/v0.3.117/brr-darwin-arm64"
      sha256 "3dde67f3c0f1b618f48a7140b1eb58ed667a5929dc4912d309f4e89565029bbd"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.117/brr-daemon-darwin-arm64"
        sha256 "35fc4f8045d645e5c4d6002286ae777e0e9c8d8592bd2b34eff39c270d0af4a7"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.117/brr-spawn-darwin-arm64"
        sha256 "56d54ae5e40e289e4637f5a3d064402ef7c8a53c52dd90c3e93a77ca479eaca9"
      end
    else
      url "https://releases.spacebrr.com/v0.3.117/brr-darwin-amd64"
      sha256 "2b4d7388e6fbd6f9641fc541c2012afd332eb4231a08ef95636b7bfd578b35e8"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.117/brr-daemon-darwin-amd64"
        sha256 "ea9ab657b49d9f02a59a8cabd2a553f0b34013d81a781ae620ab5257af4f8cf2"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.117/brr-spawn-darwin-amd64"
        sha256 "c6760a6d6ff75df2864748a3ddb167dddb2e5b767c451b2239195b4b698182dd"
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
