class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.115"
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
      url "https://releases.spacebrr.com/v0.3.115/brr-darwin-arm64"
      sha256 "9dcd00df364ecf35eb020da368c6354e0ba687b53a78e6446f0e8c18cd9f07b6"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.115/brr-daemon-darwin-arm64"
        sha256 "96450c236034e0d328e5017f6316542db6d36b964115e0df968b8fcc919a9f93"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.115/brr-spawn-darwin-arm64"
        sha256 "8cc7b84102e0563be328244bdd6601fa3ac8e3a365859fec318f11bca12a02d5"
      end
    else
      url "https://releases.spacebrr.com/v0.3.115/brr-darwin-amd64"
      sha256 "62c6c6db8c9ef7dcd670cae6a3a51b88cfafa6ada59f84b12426156acf325a80"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.115/brr-daemon-darwin-amd64"
        sha256 "fa0b4e79347cd911823880f7d37e614efc0886876708a040b68688bf689b1d28"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.115/brr-spawn-darwin-amd64"
        sha256 "054b63c6025be10d644320c3315a8a34ad9a05f75563aa831ce053e2ce49d56c"
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
