class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.122"
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
      url "https://releases.spacebrr.com/v0.3.122/brr-darwin-arm64"
      sha256 "b9912bfb5b984f6e273cacab30f478b4b3bc1ab255d11ae7b17a5027a2f99308"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.122/brr-daemon-darwin-arm64"
        sha256 "ca97492eecc6765d6cc1facce14774f22a85acd7a6386d3e4f2f3f89232f7678"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.122/brr-spawn-darwin-arm64"
        sha256 "26cf32b8899615a24e764e0d7957a7be7d0245118ab942aa760db2dfb35eac3d"
      end
    else
      url "https://releases.spacebrr.com/v0.3.122/brr-darwin-amd64"
      sha256 "9c969b5c580459305920785ce22beacbcd001f7333d14de5cb29928bf00f7d91"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.122/brr-daemon-darwin-amd64"
        sha256 "554de194dcafeb5e8efe658c5e9170e598222548e8286526946055b991d5c14c"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.122/brr-spawn-darwin-amd64"
        sha256 "f228707c39a61645937ef2baafc32c12fbcf3779da34182998b29d0413b36099"
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
