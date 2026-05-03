class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.43"
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
      url "https://releases.spacebrr.com/v0.3.43/brr-darwin-arm64"
      sha256 "f2e9daea53c8555e7a46c5261813c22bf56430c7afdcab6d395e8a7118ddf612"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.43/brr-daemon-darwin-arm64"
        sha256 "03bf295d6d1e35299b1fec64642204514a23e98b834f6130679b62e2fa6201a5"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.43/brr-spawn-darwin-arm64"
        sha256 "f32f7d51f448a56525b35a842244bec4b6df03f520cd005db6ddde95ebb8deff"
      end
    else
      url "https://releases.spacebrr.com/v0.3.43/brr-darwin-amd64"
      sha256 "dd0880587527ad5e2ebea77d6895e381733ae7519a55a70450eb092bf3455876"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.43/brr-daemon-darwin-amd64"
        sha256 "56a93baf7be830a811895a48b35a0cbc8d1aecdb951315dd8eadfcde4a498254"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.43/brr-spawn-darwin-amd64"
        sha256 "36d5b826cfd608ed82915950ba47829a46af19d71801b5cc8e95e327f559c64c"
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
