class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.31"
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
      url "https://releases.spacebrr.com/v0.3.31/brr-darwin-arm64"
      sha256 "3b2f9d8036962f84533e8329b416014eb61d03751d03fc780e87ebad11a5cba7"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.31/brr-daemon-darwin-arm64"
        sha256 "2d9b11c0ce821e0bf61150c9b07a9306300ed72bfd38ce38d27f3c9c2acf06dc"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.31/brr-spawn-darwin-arm64"
        sha256 "7626d74d67781bed1fa457153498513a1c3453b3fa74865ac95f23b11cea2bd1"
      end
    else
      url "https://releases.spacebrr.com/v0.3.31/brr-darwin-amd64"
      sha256 "ab1946492d5cf25f85554d5856a8e59c30e7a1ed569d6196e82600a45895bdc3"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.31/brr-daemon-darwin-amd64"
        sha256 "2bff63d4246e26e96f1201d7c26e8e626566dc896b9701c2177657127b8ad250"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.31/brr-spawn-darwin-amd64"
        sha256 "0f0b9e1d0a64c9a31275debb3057f03100d542b65fdf60f805de4a75b25938a2"
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
