class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.27"
  license :cannot_represent

  on_macos do
    if Hardware::CPU.arm?
      url "https://releases.spacebrr.com/v0.3.27/brr-darwin-arm64"
      sha256 "e08c73ac1f1a023182b782aa2032cd476f4220aa24acfa6be4f2a8eb255407f8"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.27/brr-daemon-darwin-arm64"
        sha256 "aa8ae9c8f5db871e58466408697bcc54e4ee4e2179fe22912fbfbc2d8530bfd8"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.27/brr-spawn-darwin-arm64"
        sha256 "596b77cd4ebc795ab336a0c578e1abac100118e0a111bc6b48d02de4ef15eee7"
      end
    else
      url "https://releases.spacebrr.com/v0.3.27/brr-darwin-amd64"
      sha256 "54fe8e28a7ee33aa185f2262b873adc91c33f56b156466d921c364c1670fea79"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.27/brr-daemon-darwin-amd64"
        sha256 "e49d525a2826ca3f73a9e1d6c8743d73e538d5df1afce92d9485b4023d942b7a"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.27/brr-spawn-darwin-amd64"
        sha256 "31521f3b34963003d12e072eafa619cd53ac8cd8eef98a1b70bff432acc11443"
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
