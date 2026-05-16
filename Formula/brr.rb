class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.59"
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
      url "https://releases.spacebrr.com/v0.3.59/brr-darwin-arm64"
      sha256 "5a92c9c623fa331fd3d734694a44d15af8d915272954c2ae20c0f5fcbe58267e"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.59/brr-daemon-darwin-arm64"
        sha256 "2d515a6246f78a801954124eda997c4886d1a91af0ee26f491bcacf3b8992951"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.59/brr-spawn-darwin-arm64"
        sha256 "c5f6d440398d9a372ff47dddf7fad5c731013a3242af5ebd876755bc9b01293e"
      end
    else
      url "https://releases.spacebrr.com/v0.3.59/brr-darwin-amd64"
      sha256 "fbc323b87fa3819f24772d236104765363fc611e9ad76e5884b03584f1914e93"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.59/brr-daemon-darwin-amd64"
        sha256 "a1f56d1eba239e798fc16af7895efb869c4b161be7b7636dec0d86c3da81f909"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.59/brr-spawn-darwin-amd64"
        sha256 "372d4da2f86e6893c4a613a002a3c9f39ebfd0476654493d43e1f249b165afc7"
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
