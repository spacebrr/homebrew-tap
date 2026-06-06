class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.74"
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
      url "https://releases.spacebrr.com/v0.3.74/brr-darwin-arm64"
      sha256 "37fe0f0088973bd49a675c648eade62e36762a237a9589c2ab745102c3c2adcd"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.74/brr-daemon-darwin-arm64"
        sha256 "ee43a58e6d0aa388a346e2cba53053b2fe68fa7b285f0e3ef882d1137f0dba3e"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.74/brr-spawn-darwin-arm64"
        sha256 "23fe823150b532f79a8af25a5399182accf5d1da5bdc3ff38d80916cbb821fec"
      end
    else
      url "https://releases.spacebrr.com/v0.3.74/brr-darwin-amd64"
      sha256 "4321ce8d6f8a6638c90d328a8d86afeb40a6ca10be88e1d8a1c1981e38b2d614"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.74/brr-daemon-darwin-amd64"
        sha256 "49af3c8abfdc3be21bed0a8ed01fc370565e82b53ac4e28156fc3d3ef124c9ba"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.74/brr-spawn-darwin-amd64"
        sha256 "f9b7af1a0b49be4ccf6ec9bf62836e0a67cd201b217ef0140e92ec69a8d6ab33"
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
