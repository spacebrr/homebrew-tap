class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.29"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://releases.spacebrr.com/v0.3.29/brr-darwin-arm64"
      sha256 "d7071dde2c45352417fdbb7b5e053947f2fd4cfacfc1119f5d07435bc7f82c93"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.29/brr-daemon-darwin-arm64"
        sha256 "c7379ab05e48c7c3378b2f57607e0e0456c8c99a29af9e6ace4807bbac398968"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.29/brr-spawn-darwin-arm64"
        sha256 "70fd60987749d4cae0eceeb7ecab3f546efad6c74db1b9128760057d1661797a"
      end
    else
      url "https://releases.spacebrr.com/v0.3.29/brr-darwin-amd64"
      sha256 "79c86af6946cbaac2c3b472e62d27ff42e71a3c50e70bd3f21d02f45cfcbf253"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.29/brr-daemon-darwin-amd64"
        sha256 "ab48802350a04e946737a322cd7a860cec5d42f8532cd3b89a4f449dae4962ef"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.29/brr-spawn-darwin-amd64"
        sha256 "b446e448f209d150127c60f1e845e0e085ceaad611cacc43bd0dc3af9c53402f"
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
