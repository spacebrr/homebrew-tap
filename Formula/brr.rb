class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.114"
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
      url "https://releases.spacebrr.com/v0.3.114/brr-darwin-arm64"
      sha256 "4516ff22467014cb78da393aa28ceac12833fd84c88620502f2269e4130a71be"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.114/brr-daemon-darwin-arm64"
        sha256 "554d4922723dda26f9b97a6a7bd1345646dfebebcb5d11199113aad50ee3921f"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.114/brr-spawn-darwin-arm64"
        sha256 "f138d4d6102cc0f03653ff1ab0dca57a1cfc27db18dd001aa4976974cff53624"
      end
    else
      url "https://releases.spacebrr.com/v0.3.114/brr-darwin-amd64"
      sha256 "d676eb0e7892313a7a43471802c0871297daeee7466bbf6f381a7c0de874249a"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.114/brr-daemon-darwin-amd64"
        sha256 "b3e377dec5a1ed16f18b5ccda1c213b0dac996fc58069e34cb618aa39d3b6f7c"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.114/brr-spawn-darwin-amd64"
        sha256 "35e7487125cf7d835f6277a26220742d9a0eaf4cfaa46db6cbb7cc0bddec905f"
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
