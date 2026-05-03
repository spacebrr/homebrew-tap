class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.37"
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
      url "https://releases.spacebrr.com/v0.3.37/brr-darwin-arm64"
      sha256 "442efb1489c6532b103feae4ff3586d2d294ea4144260db6e3b423c0eeed9647"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.37/brr-daemon-darwin-arm64"
        sha256 "903a327cb2c55cb1f4af5341c75fc2fe837072cc584c855bdb6f645020401cde"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.37/brr-spawn-darwin-arm64"
        sha256 "85aa613aa4d8862c65b4bce4480502451f26a7998259c9d2cfd460da3a4dafcc"
      end
    else
      url "https://releases.spacebrr.com/v0.3.37/brr-darwin-amd64"
      sha256 "7b1344875bbf08e2625056c3ba62bc4b10dc35e96efff050ff871e4c5f260143"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.37/brr-daemon-darwin-amd64"
        sha256 "b7b15461dd38eb8d2b7e2d09e7b86f8605cf8b1e1f3360be66824b173b2c1ce2"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.37/brr-spawn-darwin-amd64"
        sha256 "2b00fca4c2e9e50507e256ef40249262cbdd7dc9cd3adf87e345ed1c77bbf708"
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
