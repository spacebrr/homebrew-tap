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
      sha256 "17e0fe6f2ae5032da45de7387125ca3c23804d7805be96461865030672b15611"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.36/brr-daemon-darwin-arm64"
        sha256 "89fb8377f3e605cdbc603335463401f34e6690f89067b5da559dfc3eceba4998"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.36/brr-spawn-darwin-arm64"
        sha256 "999c18c8700d20ca767c9784d8a872c89b9b2dc12ea07a058f5836a84562a4f3"
      end
    else
      url "https://releases.spacebrr.com/v0.3.36/brr-darwin-amd64"
      sha256 "53e54f6739dd8876a4540204d82740bc5bb2c20745b0be2ca27f75fc57960b78"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.36/brr-daemon-darwin-amd64"
        sha256 "5d4042d455a24e9debf30810ee9828c1439608a5e4347ebf1f56bee44b081e70"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.36/brr-spawn-darwin-amd64"
        sha256 "bbbe6fb4247ac45cbd7c3357771df1d73565ff1208e11a81f608fe073f50501f"
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
