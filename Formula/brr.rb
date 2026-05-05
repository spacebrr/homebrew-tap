class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.50"
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
      url "https://releases.spacebrr.com/v0.3.50/brr-darwin-arm64"
      sha256 "a9c1e3ba3129aed8397175e7ef0bb924c5433017c01fe743d205245e4e4b848d"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.50/brr-daemon-darwin-arm64"
        sha256 "6a3e12497dedf5ad7bc89ca9010675f033a5cd31d925523b98fe8ba11f6ef8f5"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.50/brr-spawn-darwin-arm64"
        sha256 "4f9e9f40070001189d8446a1a04a847e6912cad94f9b095d0b53b60f2b6a6868"
      end
    else
      url "https://releases.spacebrr.com/v0.3.50/brr-darwin-amd64"
      sha256 "2a01d8bc26d1149673b5e7f7646b8ee214f4a89974e750a243984f2dbef55cb6"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.50/brr-daemon-darwin-amd64"
        sha256 "c0aa9e4bde135ced402a86684fdf430088f91736dd5875179695dd981942a3a2"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.50/brr-spawn-darwin-amd64"
        sha256 "95552c511ca1642f258dfd9d64f9927e498d58d54321033721a83e0261b4d426"
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
