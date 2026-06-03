class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.71"
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
      url "https://releases.spacebrr.com/v0.3.71/brr-darwin-arm64"
      sha256 "febc080b1aacc2c4e8b2c11e4a604c6809d02ee18715d96d858ed7afb23fcd81"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.71/brr-daemon-darwin-arm64"
        sha256 "628b0d5fe42ba17d69f29f5946bbc2581242e366b92d06a7ebdf3a23d28119fe"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.71/brr-spawn-darwin-arm64"
        sha256 "1280064b3831f0910fe94a88edcc2c67f2eeddf98bd54898e615846324967ca5"
      end
    else
      url "https://releases.spacebrr.com/v0.3.71/brr-darwin-amd64"
      sha256 "2376ea6d45d4817c9d843b9ae00815ace5ebd58c607a3a3dc865dc411e9c4300"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.71/brr-daemon-darwin-amd64"
        sha256 "606cd48addaf1691399a7a8b17760bc8734b6bbca2f71ec93afe495c85e7dbb9"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.71/brr-spawn-darwin-amd64"
        sha256 "d2789804ef7ab1c18cbfdd3fbcea09fb61c038950ee1f3f57f943a0f624cfa7f"
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
