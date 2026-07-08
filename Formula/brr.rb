class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.108"
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
      url "https://releases.spacebrr.com/v0.3.108/brr-darwin-arm64"
      sha256 "548ee7876af7b9b93505be7765900e53cf9ae7433fbf01e1645d993f0d9b923d"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.108/brr-daemon-darwin-arm64"
        sha256 "8a7694b5d0039d378a2e6eaa9cd148f57d0f495805d15dc431c2df3b1fefe6cd"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.108/brr-spawn-darwin-arm64"
        sha256 "758dbfb05296b65f504985e574fe8b0dae0b0dd2d7292fc9dcb36fc19d7fd0eb"
      end
    else
      url "https://releases.spacebrr.com/v0.3.108/brr-darwin-amd64"
      sha256 "26e5ab6f7d83fc2c79f2b1a4ee42262e7e2586bc6bffb166f88df65b5bbd87be"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.108/brr-daemon-darwin-amd64"
        sha256 "e979d5e8665a13dbbd2bd0453f7db92818d3fc6f7781e6a1c2c23d4315a1089a"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.108/brr-spawn-darwin-amd64"
        sha256 "d6f5a9c527616bfc9514328c488c1b64089786775492a9404de54ec764c4ada9"
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
