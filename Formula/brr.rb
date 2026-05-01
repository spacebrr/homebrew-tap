class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.30"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://releases.spacebrr.com/v0.3.30/brr-darwin-arm64"
      sha256 "a99369bcc56e028d206ff2542cc3c454a7b9658bda8acdf0a8dee48b833383c3"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.30/brr-daemon-darwin-arm64"
        sha256 "c92ec7296f2933c3f23c26e2969d2ca7e65acd6ef25faafd85c69e3c1b0e946c"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.30/brr-spawn-darwin-arm64"
        sha256 "6eb7fbd90dbc1634951589a00335536feb14d46859e4ee9af832fa8968dd9320"
      end
    else
      url "https://releases.spacebrr.com/v0.3.30/brr-darwin-amd64"
      sha256 "cde10649caf929a60c532a602932e8957d13724d72b31f9e0364617ac9efccf9"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.30/brr-daemon-darwin-amd64"
        sha256 "b48ccca6eb2fbfde683a2d698f4abb273ebde83e48f20426a8b25fb876cd48c8"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.30/brr-spawn-darwin-amd64"
        sha256 "3fe41a155baf7b242cba4f74e8a2af55686da6a7ba086eb0699593221d69daff"
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
