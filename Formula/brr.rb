class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.118"
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
      url "https://releases.spacebrr.com/v0.3.118/brr-darwin-arm64"
      sha256 "c6b72456932d3eed65b3ccbb20ad80fdc1cdef386edc3b4e3f7f7e9e43fd4dc9"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.118/brr-daemon-darwin-arm64"
        sha256 "3a9d8b950c0d10031244eb1b15453325adeb1d9e00590eaa8ec103f1554a3d23"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.118/brr-spawn-darwin-arm64"
        sha256 "b10ca3b1624f78fd2c5e76cb5a6cf01bedc562e96563e660da5a0d6fb8fd3058"
      end
    else
      url "https://releases.spacebrr.com/v0.3.118/brr-darwin-amd64"
      sha256 "788a0583d45dde13e37f09454ced281db9ba07a173d03707dcac01219c771765"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.118/brr-daemon-darwin-amd64"
        sha256 "b1c34eba114d5a51b37d670a5058b4a53836ce43d83c520c9f77dfd362f4d699"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.118/brr-spawn-darwin-amd64"
        sha256 "66b34ebbab41fb5f8e969e6a1d75f65abcec6f3ee29c212e6c4b99ea1b0687f1"
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
