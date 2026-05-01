class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.30"
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
      url "https://releases.spacebrr.com/v0.3.30/brr-darwin-arm64"
      sha256 "c2b694a01ac8acd6296f03e2efafde1ddbf50790b5910efa64afcfb19a25accc"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.30/brr-daemon-darwin-arm64"
        sha256 "59d1430a68ebb3e620f60a3299ed2610766291c507c4400bdaec9960d9fe3aca"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.30/brr-spawn-darwin-arm64"
        sha256 "c0548fbbaa171ea53d25ce4443aef6be93517cbffc31b7ef5298033596dd354a"
      end
    else
      url "https://releases.spacebrr.com/v0.3.30/brr-darwin-amd64"
      sha256 "c2258831c81e1983f02bbd19ac0b8f6f4479d00e4713625fd56950e0745a10c2"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.30/brr-daemon-darwin-amd64"
        sha256 "3b3f033bb018d796c45cf885b5fe4f923c7acdbfc761ee5258df03562ae36503"
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

  test do
    assert_match version.to_s, shell_output("#{bin}/brr version")
  end
end
