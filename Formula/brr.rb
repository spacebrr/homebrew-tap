class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.35"
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
      url "https://releases.spacebrr.com/v0.3.35/brr-darwin-arm64"
      sha256 "175aba77c80093846f6e9addd808132899681832b1e3a4a3ca9254cf5bef287c"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.35/brr-daemon-darwin-arm64"
        sha256 "68d2e3d038737b98fae9b510b4d7d9029407c50bb48aba813cb6fdac90847a10"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.35/brr-spawn-darwin-arm64"
        sha256 "cf8492719fe96757cfa42053905226ceedcba6320b08a6590c6c97af23469c3d"
      end
    else
      url "https://releases.spacebrr.com/v0.3.35/brr-darwin-amd64"
      sha256 "a29dfaf8544710bcfc5cc0eb0466364addad40da3388821f0f1c13b9524ed881"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.35/brr-daemon-darwin-amd64"
        sha256 "f63dd40a019aec8ca80f611d4ec4dad6a2fa946a1585d13bf2952336b922c45e"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.35/brr-spawn-darwin-amd64"
        sha256 "3776c4a582bbe22b65063606ee121bf407893412ee132d42bdef9f92af6fd1a0"
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
