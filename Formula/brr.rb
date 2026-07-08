class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.110"
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
      url "https://releases.spacebrr.com/v0.3.110/brr-darwin-arm64"
      sha256 "5d6e25141b82be08f63d2c4749dbeb03369a7dd11a2a310fcbe6c9941c142e92"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.110/brr-daemon-darwin-arm64"
        sha256 "87ff2163c67e2211875fc8e2a8d40d89f68311d6fe70ae61fa400eb1eccdb557"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.110/brr-spawn-darwin-arm64"
        sha256 "1f424c56ad9ebd143caa9f2d0477a4a39c122725cf1e5c07637780d00a2cbc49"
      end
    else
      url "https://releases.spacebrr.com/v0.3.110/brr-darwin-amd64"
      sha256 "8829cb5f0757a1dabbb5561cae9cfe77f388ee50df2fcafe593392fe7d3445ff"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.110/brr-daemon-darwin-amd64"
        sha256 "21800d934d0d4f750965bc1e1ed2ec776a1a47b097f5865354df335c9bd7c50b"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.110/brr-spawn-darwin-amd64"
        sha256 "8b38b2ae42c036c011769539c24844c28ba85a8090e79a3000b89431d00af6d8"
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
