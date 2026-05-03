class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.36"
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
      url "https://releases.spacebrr.com/v0.3.36/brr-darwin-arm64"
      sha256 "0eecad1fe2277e5f116c610d0a4d2f021438b64d4207a40c4d95f72123c36ad6"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.36/brr-daemon-darwin-arm64"
        sha256 "63078d3cb6e26b45211618e7523376c2413e892433d74d4221acfdd05f39d4e0"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.36/brr-spawn-darwin-arm64"
        sha256 "f6195236cde4a880f014f7378c1928c56de7321ad6cdb73a71cea2d3ade48c72"
      end
    else
      url "https://releases.spacebrr.com/v0.3.36/brr-darwin-amd64"
      sha256 "f030c02f8dbaa51fb4a91d137eb4fee6bcb62d530bb540ff912e4da1983fe38a"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.36/brr-daemon-darwin-amd64"
        sha256 "4834f32597bf2d7712c81aa78c47f1a461775e4c2edcdd661e005412e80f9684"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.36/brr-spawn-darwin-amd64"
        sha256 "675efceb48571113d45eea8c2496fea1965dbe9674ba3ed4bbd79b1c9013d9df"
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
