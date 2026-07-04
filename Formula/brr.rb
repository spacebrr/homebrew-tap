class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.96"
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
      url "https://releases.spacebrr.com/v0.3.96/brr-darwin-arm64"
      sha256 "1f80fc93b044ba605c3e670f9af56893250c54321a6583da19fcd51a02727052"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.96/brr-daemon-darwin-arm64"
        sha256 "f3f0332815482abcabe57a3666e0dd63c0315fba2d75b238de1c9d180c6731e3"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.96/brr-spawn-darwin-arm64"
        sha256 "fbbd1d26fa9db5f8889a08de02f80aea533972a570492b3a50ddca08e47d5f3a"
      end
    else
      url "https://releases.spacebrr.com/v0.3.96/brr-darwin-amd64"
      sha256 "a07a55cf45de15a0e1d76a04bd791c2cfff47ad6e0109fa0cc8e626633a8ef8d"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.96/brr-daemon-darwin-amd64"
        sha256 "5da8d9a1c2e0abbb8862f3507c01bcd4eaae111d0fcfbab1e9154de8592f7e45"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.96/brr-spawn-darwin-amd64"
        sha256 "b55f7de8c77dd673252d0c1edc455a1c94f2577d6efb58d9d311ddeeb75f6d96"
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
