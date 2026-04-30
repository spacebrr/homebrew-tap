class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.24"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://releases.spacebrr.com/v0.3.24/brr-darwin-arm64"
      sha256 "98e8d88caa165a88e7176e3a8f6273deb1df015c70f6801c37b47d7804113645"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.24/brr-daemon-darwin-arm64"
        sha256 "fe317a13433969d0391254172cfb8c062808cbe4ef9501433fd24a1146da7cba"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.24/brr-spawn-darwin-arm64"
        sha256 "37ab1020ba81fd18878a43e5b3cd8399c8e5f27f183541c754cdc19a9e3bea5e"
      end
    else
      url "https://releases.spacebrr.com/v0.3.24/brr-darwin-amd64"
      sha256 "0f3a517445f4909e19bf289cea2b47aea9297cb73ba04fa4175cd344966402f6"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.24/brr-daemon-darwin-amd64"
        sha256 "cded27c76cae69d6d7922bf91e6f2477cd73b5dc6fc690f3ddc8d7821f0293a3"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.24/brr-spawn-darwin-amd64"
        sha256 "3fb9fed660708654763d06004264c9cccd936c0f8637bcd7a88f58ebfd1dc74c"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://releases.spacebrr.com/v0.3.24/brr-linux-amd64"
      sha256 "af7a58a56e6931b367c5e86f5f56780c0efad3b856694baf2cd0fd3f99414f80"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.24/brr-daemon-linux-amd64"
        sha256 "2aff254ad659e3572cb431cf2036cd01a365800b55694037a7fe3e1cdc47c032"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.24/brr-spawn-linux-amd64"
        sha256 "ab29672761da4763111a49b25f503cc201a18db73d807770edf02b34226ae1e3"
      end
    end
  end

  def install
    bin.install Dir.glob("brr-*").first || "brr" => "brr"
    resource("brr-daemon").stage { bin.install Dir.glob("brr-*").first || "brr-daemon" => "brr-daemon" }
    resource("brr-spawn").stage { bin.install Dir.glob("brr-*").first || "brr-spawn" => "brr-spawn" }
  end

  def post_install
    system "#{bin}/brr", "reset"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/brr version")
  end
end
