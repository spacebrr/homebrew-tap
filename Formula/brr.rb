class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.78"
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
      url "https://releases.spacebrr.com/v0.3.78/brr-darwin-arm64"
      sha256 "c4246d97e7f1b0ae460a24140b2c455cab21e7a621197c0a4ad06280ea3a67fa"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.78/brr-daemon-darwin-arm64"
        sha256 "436c64888c59e66a7068fb09617ebf73039da21e0d1762c6f943d488b430ee83"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.78/brr-spawn-darwin-arm64"
        sha256 "c06b6dd4c052e4490cabac5ef42f294747aae3b73fb20613c63eac41426907c2"
      end
    else
      url "https://releases.spacebrr.com/v0.3.78/brr-darwin-amd64"
      sha256 "24a0a9ddd80e292f896185a9422350dea8bd92cb67bb405dc6f8281f59ce9b6c"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.78/brr-daemon-darwin-amd64"
        sha256 "aebde05f7eddd11cdaf9a0369cd7184f986a3cd1c45dc273f9ed0c5ff43a1ca6"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.78/brr-spawn-darwin-amd64"
        sha256 "009f3dc64465b80cc924616e872d943b98f6ccf54380589fcaf7816ead1a7fc2"
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
