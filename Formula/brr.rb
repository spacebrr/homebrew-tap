class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.57"
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
      url "https://releases.spacebrr.com/v0.3.57/brr-darwin-arm64"
      sha256 "736dbadf480feec7bfa75621eff438ecb9eb46b94be4865ecbe825abafc792be"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.57/brr-daemon-darwin-arm64"
        sha256 "541c40a48938a3ce31d355f5c0690abc6e88293d283102feb2f495ff0cbcaa67"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.57/brr-spawn-darwin-arm64"
        sha256 "90f010defba1855f7a646a4bcd41e65e4190fb1179ef3f2fd069e5affcc965dc"
      end
    else
      url "https://releases.spacebrr.com/v0.3.57/brr-darwin-amd64"
      sha256 "84c1d14a426c7932ddc2942e822743af259eb6a9f2f1ebfb92c39fc54165a9d6"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.57/brr-daemon-darwin-amd64"
        sha256 "84fac2aa7553bc4c2b9c5b307b1f8405fc4efc119d3a0b498c067f30046b52c7"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.57/brr-spawn-darwin-amd64"
        sha256 "2c58032320a25e1f6fa00ea1a6d0db030741aa6b7fc664c3c96265712fc1a3ad"
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
