class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.49"
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
      url "https://releases.spacebrr.com/v0.3.49/brr-darwin-arm64"
      sha256 "68785ccf8e06cb2e5c74cf22fb834b7ebbc9ca138caafa8affab53c5cb7c4be8"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.49/brr-daemon-darwin-arm64"
        sha256 "094a2175271317a7d5551b4a22f80f527788025752b2d2d7a720a22bbf60b907"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.49/brr-spawn-darwin-arm64"
        sha256 "2d059a9170db7359dd8b7a03a144393e1d88d34482323b55fd32c0daa53d3479"
      end
    else
      url "https://releases.spacebrr.com/v0.3.49/brr-darwin-amd64"
      sha256 "55c7c067c3e00f7f529f2e1088749d1dbfaa45ddc52297ac3b18dee291a1f9a6"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.49/brr-daemon-darwin-amd64"
        sha256 "2ed6ff7537d0672e71f50fc686c4c8c2deb7d4fcb1153f27246ba977375f6fd6"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.49/brr-spawn-darwin-amd64"
        sha256 "c25a8cdbe038954be82e8d6971272238c1528e9cf5e19ebb392e73e8956c5598"
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
