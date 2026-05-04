class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.46"
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
      url "https://releases.spacebrr.com/v0.3.46/brr-darwin-arm64"
      sha256 "86c809493c5cbc71e1d0301b2e0d952fa39b5a6d3d55c6bd8f2c0fdc4ab70755"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.46/brr-daemon-darwin-arm64"
        sha256 "b1368f0ada03e9aee5e5f9f01cd60d3863749c3a6fdcc59a61769a3285e2302f"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.46/brr-spawn-darwin-arm64"
        sha256 "387a254f4448b7a741c67239c7c5cbb25314eb1901bc642024ac03c379d690f9"
      end
    else
      url "https://releases.spacebrr.com/v0.3.46/brr-darwin-amd64"
      sha256 "794b13dd7c9f23525a2e3ff0b9c3719949904902fa4cbf83169f8bef0eecfe42"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.46/brr-daemon-darwin-amd64"
        sha256 "921d8b220a7ed4b63391ba42e4ea95583df9a426d2bfb6273bf52d844d21933e"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.46/brr-spawn-darwin-amd64"
        sha256 "5d83b5e48223799da440142b830287c406dad8f7e8c35896a3a94563688a56fc"
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
