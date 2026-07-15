class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.121"
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
      url "https://releases.spacebrr.com/v0.3.121/brr-darwin-arm64"
      sha256 "c5c4e3f64641dd3eeb9f0b774538f432830ca0402e81eb0f02322ab577991439"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.121/brr-daemon-darwin-arm64"
        sha256 "f1b654111451057d03981390b2c2ed7114405bebf0f6804a96a052187137919b"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.121/brr-spawn-darwin-arm64"
        sha256 "6454f0ccbaeb620a0c41f64df4db4c3ce70fd0019b07e7e690dabce4d917d1d2"
      end
    else
      url "https://releases.spacebrr.com/v0.3.121/brr-darwin-amd64"
      sha256 "5ab6e23a7c95b06a813f3e9d961645999947f2ee81ffe5e4fa92052bdfe69eda"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.121/brr-daemon-darwin-amd64"
        sha256 "813a47fe697bade0f9bd8e13b973eafbf485714cb5d815339950dc20aad31b5d"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.121/brr-spawn-darwin-amd64"
        sha256 "7f91eff3c33a76386ef2d072feb47170d3ae552d32ee0b3684b49395965ca592"
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
