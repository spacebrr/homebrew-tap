class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.53"
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
      url "https://releases.spacebrr.com/v0.3.53/brr-darwin-arm64"
      sha256 "be72be480e5289661aed4f1353c52953186ca250828cc949c22b68447ea1621b"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.53/brr-daemon-darwin-arm64"
        sha256 "3cc68900746b70190c33b637be86200c781e15044916ffa5d473deef91044471"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.53/brr-spawn-darwin-arm64"
        sha256 "80e727cf3cf77d9c1080444997e7e757cb7cac1075cf945a762d62287bf08696"
      end
    else
      url "https://releases.spacebrr.com/v0.3.53/brr-darwin-amd64"
      sha256 "096f19f56b6b78730b131ea42cfbfdebdf7f42e7a7c28fb4e766428296691c8c"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.53/brr-daemon-darwin-amd64"
        sha256 "9d253e7c14601a15376c1901ea3fbdf0732522c75755ec654e5657f317ac0c80"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.53/brr-spawn-darwin-amd64"
        sha256 "51f0cf772c7c05fbca0b9a48f35901acc0b6f63c7ad088a757c9c6ee16802893"
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
