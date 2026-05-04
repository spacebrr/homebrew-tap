class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.47"
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
      url "https://releases.spacebrr.com/v0.3.47/brr-darwin-arm64"
      sha256 "7e11533ed2746cb5291c8662c6dd7b7f12d9b738f0138364c7cb42129c6c0afc"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.47/brr-daemon-darwin-arm64"
        sha256 "b1bce16e4c236e6c2f70037a00714d17b0be1533e2417c939be0f60590b03f9f"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.47/brr-spawn-darwin-arm64"
        sha256 "d25ded90badc7a7719ecf53564754f2bb9318e9a2732ff67f3c473bd5e3bc2ba"
      end
    else
      url "https://releases.spacebrr.com/v0.3.47/brr-darwin-amd64"
      sha256 "a49db727a8b12e8912582558613c0ad798e14f85c1f55cacecef377a21e5af80"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.47/brr-daemon-darwin-amd64"
        sha256 "d850b6e916ce6fe51a592815e3dd0f3c18028cce32080d4cf6ab361c45d9fce3"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.47/brr-spawn-darwin-amd64"
        sha256 "41516f7bc3719b3e04614c215629d8513a2caf4a6a3b243031e8060500b3d5dc"
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
