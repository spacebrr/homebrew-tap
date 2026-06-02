class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.69"
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
      url "https://releases.spacebrr.com/v0.3.69/brr-darwin-arm64"
      sha256 "f4ad0d48ab1ef1fc52fc2ae69f87a8027f6b26bb41289a13cc6c29663ecd0795"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.69/brr-daemon-darwin-arm64"
        sha256 "cf7a2b4cffa5486e74ce6ff77394c30650759cf480315e3b94298dc6958e2a11"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.69/brr-spawn-darwin-arm64"
        sha256 "2deafaac079e38f042cf57495c613fcc18795387854d663ff6adbf532ff9f15f"
      end
    else
      url "https://releases.spacebrr.com/v0.3.69/brr-darwin-amd64"
      sha256 "adefc9687421a8e4982490fc97b62416c2adf9e9b67701686147cb29ae2f587e"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.69/brr-daemon-darwin-amd64"
        sha256 "12090f466003f96ed73322c7af6127576085bdaa26127aaa9a9e5e65ac2db3a6"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.69/brr-spawn-darwin-amd64"
        sha256 "165d17074193b60b756c332cb1e7dc208ac2cebb516d4bbba645a5cbf1728e2b"
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
