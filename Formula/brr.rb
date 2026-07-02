class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.82"
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
      url "https://releases.spacebrr.com/v0.3.82/brr-darwin-arm64"
      sha256 "a63dac22bb47e70ab0fa854256cc1d72737c8b150cb3fe28d094f5c32f33af25"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.82/brr-daemon-darwin-arm64"
        sha256 "4f6c4328c5ab1e9f5a3dbca10eae02e7a79cf21117e1e922ac55b8ec75239d98"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.82/brr-spawn-darwin-arm64"
        sha256 "57a978efe5e3f675a4fe395f2789a7895b94c2c9f1ec129ce4e637cc382fb949"
      end
    else
      url "https://releases.spacebrr.com/v0.3.82/brr-darwin-amd64"
      sha256 "b8fc7009ac424fa9cdb30b000bbdc9283f6025ae1d2b2496d5d33cbc42bbe7ca"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.82/brr-daemon-darwin-amd64"
        sha256 "8d21d7fb8c0c9f4e10d59577049b020cf5ab72ead6ead12e44b78655f27cb65f"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.82/brr-spawn-darwin-amd64"
        sha256 "3d2343efa506e86e0884971e4f7ab7e39461f0d2242b575661cfcdde443fc7e5"
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
