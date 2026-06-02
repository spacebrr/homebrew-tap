class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.68"
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
      url "https://releases.spacebrr.com/v0.3.68/brr-darwin-arm64"
      sha256 "c1f588f579037d04322e1bb4a2887ccf614baac2b5c7b810ae8d4aeb6a4d0a9f"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.68/brr-daemon-darwin-arm64"
        sha256 "7977c3782f3b08e8d5a9aa68fc04c4ea9d77b33ae84f3a039dd2ccd89789eb88"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.68/brr-spawn-darwin-arm64"
        sha256 "0c1d4714dd5cde0ed450a2359e1807644d14950279819a7c6657165a35fdaff3"
      end
    else
      url "https://releases.spacebrr.com/v0.3.68/brr-darwin-amd64"
      sha256 "84758bb243fd7eca4b1901384ac1bc1a2c0ffabe12937db0fe3abc4db55155bd"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.68/brr-daemon-darwin-amd64"
        sha256 "0754a5bf13420bfc9fddf9c3cbea9e269f6a60b3b4e5367872af1ba0915c5cbf"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.68/brr-spawn-darwin-amd64"
        sha256 "1ff0ecc67e75b7e7284d3c1485315b24c01d1df0466d53ec542f4dadb5ed3514"
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
