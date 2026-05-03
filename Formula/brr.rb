class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.41"
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
      url "https://releases.spacebrr.com/v0.3.41/brr-darwin-arm64"
      sha256 "e248c65d80bc1b4459d3bc95f7f765a4af018b6d0845c78dc81645bf45fb293c"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.41/brr-daemon-darwin-arm64"
        sha256 "fbdea7c3e097f46b0cec6342cb453dd96d165f9516582e0c0b653f94cc5703b4"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.41/brr-spawn-darwin-arm64"
        sha256 "da547f1bdcc4300cf384928f896a4a3db9235ce154062af0b474c8bf41595613"
      end
    else
      url "https://releases.spacebrr.com/v0.3.41/brr-darwin-amd64"
      sha256 "823f476d9c2f8259a29ab116e50d83ff1cb47819a8f66dacfb05616b574aaa22"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.41/brr-daemon-darwin-amd64"
        sha256 "021b1083d94c27df17f538b4cd563facd8646f0f97dc92b7ea5d0e546bed1974"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.41/brr-spawn-darwin-amd64"
        sha256 "c658612b6b3f3d476d0be3da5ccccc2b9db15ca4ecdac0d02a27b72e9842c539"
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
