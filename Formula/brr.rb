class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.44"
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
      url "https://releases.spacebrr.com/latest/brr-darwin-arm64"
      sha256 "074177075b99500862ce36a08b8226ebf5b38989c339a43e7e5f322111f56b8d"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/latest/brr-daemon-darwin-arm64"
        sha256 "1d4554738a4bb7ace82447402711c3bf8061943651938ac2e46d0927ac723fc1"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/latest/brr-spawn-darwin-arm64"
        sha256 "5e5254617eb600d268a41aa097cfa00b444d1aa007a49c9ddb22115c90a04eab"
      end
    else
      url "https://releases.spacebrr.com/latest/brr-darwin-amd64"
      sha256 "9721ce03d3198e0108c031d35b5fef35591da0d130fc56544f937a10e59f5e94"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/latest/brr-daemon-darwin-amd64"
        sha256 "d66f29984a181772d155e5c52ef6466e24abd643896aeaae7a6d24e77995ec37"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/latest/brr-spawn-darwin-amd64"
        sha256 "149ca50f01fbbfa961d69177c2af1698731c19a9c780c748b5dbff708c2a1286"
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
