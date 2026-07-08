class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.107"
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
      url "https://releases.spacebrr.com/v0.3.107/brr-darwin-arm64"
      sha256 "f789511b92a78b00f35515e2b2ca5ad3f459cf61fcd56d20dc1740eeee0f3d0b"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.107/brr-daemon-darwin-arm64"
        sha256 "07691d885e66a1af91d3c7d578232fc67c93470de1f6d965eb9edd67a4915a16"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.107/brr-spawn-darwin-arm64"
        sha256 "5b1ede32878370d63b93f8bb913b002f76e64c8d8e94bef33421c868d465d335"
      end
    else
      url "https://releases.spacebrr.com/v0.3.107/brr-darwin-amd64"
      sha256 "9ad7caaf98abdebb77012d8c6e1b9d03f9711e296b28b2a5ffc773eceb534115"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.107/brr-daemon-darwin-amd64"
        sha256 "d903d8e7c2a7a23cd61a7841da5ddae216737c612dacf719ec4b2d6a54e42ec7"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.107/brr-spawn-darwin-amd64"
        sha256 "0f3217f4c31804b798d52c73e0c6eb41d24682c40f4263446c7ece8ee17472aa"
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
