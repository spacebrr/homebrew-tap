class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.119"
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
      url "https://releases.spacebrr.com/v0.3.119/brr-darwin-arm64"
      sha256 "239644b1973504ac29324ad27c28fa4f135b70121dfe83cbf937d0bce98cf488"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.119/brr-daemon-darwin-arm64"
        sha256 "e72f9b3fd58a319554465b2141c1fbfe692ce2b2378f597ba21c53978ce331a7"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.119/brr-spawn-darwin-arm64"
        sha256 "3f76553741215fb1c6e340d887fad48e283ce6a6b1106b929da01e69d38cdcb7"
      end
    else
      url "https://releases.spacebrr.com/v0.3.119/brr-darwin-amd64"
      sha256 "746b4bba0c35783d221ae3201c3d3865f6da6f4bce46bafefb472a6c5bd1fb96"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.119/brr-daemon-darwin-amd64"
        sha256 "f3eb01199e661e93ed015f0e68d982ba74243b28108df07ee034f3d1ac33a5a5"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.119/brr-spawn-darwin-amd64"
        sha256 "894bd8fb604aa0185c590eb75973975275f03496732f93cf6914558dcd66bdf7"
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
