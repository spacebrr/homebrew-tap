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
      sha256 "839d6362009d08249050f5c415410f34425228e9a7bf97b5f164899f63fe2fdb"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.46/brr-daemon-darwin-arm64"
        sha256 "237f81dac9efb1a3255a80f29f6caedf4f4e464c3f84c126272a6298bcc45158"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.46/brr-spawn-darwin-arm64"
        sha256 "387a254f4448b7a741c67239c7c5cbb25314eb1901bc642024ac03c379d690f9"
      end
    else
      url "https://releases.spacebrr.com/v0.3.46/brr-darwin-amd64"
      sha256 "c3601ddc20b20308a79ee586bbf3d75d8c85eedbd406541ebd426070722344b7"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.46/brr-daemon-darwin-amd64"
        sha256 "335e88bfbd05db474a0f92ccff24de4386ea7e4e1defc9e6ef1c7bbe7d443aee"
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
