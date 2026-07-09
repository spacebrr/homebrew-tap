class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.116"
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
      url "https://releases.spacebrr.com/v0.3.116/brr-darwin-arm64"
      sha256 "da5bed7d9c67161ed4c28b43081f7d3bb9d8ed3eccb5197350548509a6d12fb1"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.116/brr-daemon-darwin-arm64"
        sha256 "9b63e9d7f990aed6599a04e63b1199d4c4c1319d91748aab6235e6bdda641010"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.116/brr-spawn-darwin-arm64"
        sha256 "b637815e322b7d429c3a1d977ba34d97d28c10800f411b0f62f948ad90ec491f"
      end
    else
      url "https://releases.spacebrr.com/v0.3.116/brr-darwin-amd64"
      sha256 "197f0a08b9dff10c8f7d4db5414faa4c1b88c07dc5945dce8c4edcaa0877941b"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.116/brr-daemon-darwin-amd64"
        sha256 "efe7fef34cf4ea11e5256a3d37f82b5fab6e235d9d25f0b304e8c9296b02824e"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.116/brr-spawn-darwin-amd64"
        sha256 "24d8c219a8bccbe4d58f41f2cd3c6043543ae44eaf59e016c9fa46f9260136ca"
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
