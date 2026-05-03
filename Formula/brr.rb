class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.36"
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
      url "https://releases.spacebrr.com/v0.3.36/brr-darwin-arm64"
      sha256 "21c6a99f6f8937cfec24aa475cbe854769d2c382ee7f2bc089b8799ed26140ab"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.36/brr-daemon-darwin-arm64"
        sha256 "c67f92ac23b77d4a0551786049d9d023a2dd22609250fec2ed49c057db71a52e"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.36/brr-spawn-darwin-arm64"
        sha256 "33852942d7d1183c4ab82942e0675197820a4619381c205d19014a34c5f70def"
      end
    else
      url "https://releases.spacebrr.com/v0.3.36/brr-darwin-amd64"
      sha256 "10fcd5379c2659fe35631daa5b662333d35c906ce302818ace1ec2846f3040dd"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.36/brr-daemon-darwin-amd64"
        sha256 "4f0315f30b6018592eaa891dab92e3a81fe4df300918567c323da5313eaa31a6"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.36/brr-spawn-darwin-amd64"
        sha256 "872b319b4dd2b06a0c58353bb66be53de73d621eb6d15937a6fc8a4d139d3d8f"
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
