class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.58"
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
      url "https://releases.spacebrr.com/v0.3.58/brr-darwin-arm64"
      sha256 "8aef99256c3505b086bd0b68df91a1ec94b6234ac2246efdc229c97bce718c36"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.58/brr-daemon-darwin-arm64"
        sha256 "f8713efa4cbc64c9ffdaedab10e3afa1df21b288cec59fc07ef3cd6b70d7c38d"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.58/brr-spawn-darwin-arm64"
        sha256 "c53dce6dc8428d31f9a38b6be57b93556a3ce212fa1433e644f903afac1dbfda"
      end
    else
      url "https://releases.spacebrr.com/v0.3.58/brr-darwin-amd64"
      sha256 "65872723a4f2188e784e19bca0a42fa930b896681200dfc98bf345fa69029707"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.58/brr-daemon-darwin-amd64"
        sha256 "b6ca899519ba59e9c69bb3f2dd589c5ad7172adf2db69d9a232e53454ef5a088"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.58/brr-spawn-darwin-amd64"
        sha256 "bce04a4ccfb903692cafe267deccd68301f24842a230b4565d9aeedbbf14afb0"
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
