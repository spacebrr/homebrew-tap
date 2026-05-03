class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.39"
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
      url "https://releases.spacebrr.com/v0.3.39/brr-darwin-arm64"
      sha256 "219ac82e28370a17b175a81882801992718fb9042a10ecac6c065dfb3b706308"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.39/brr-daemon-darwin-arm64"
        sha256 "bbf4247089aac49b10fd10daf08fcb743d5219abee6b5f645bc5492761f07b6e"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.39/brr-spawn-darwin-arm64"
        sha256 "08bd0a9ba9bfac5e49b2cf5850cc2319173ef8db13b2c54a4ebd63a8367d4b17"
      end
    else
      url "https://releases.spacebrr.com/v0.3.39/brr-darwin-amd64"
      sha256 "e7e5e59a62842393623812851b27f707d965ccb3374b8d2f84d900656e36f4b5"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.39/brr-daemon-darwin-amd64"
        sha256 "a7853eeb636bdb5803ebfeb3402eaf77e6196ee119c0e176f75f7082c4df4306"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.39/brr-spawn-darwin-amd64"
        sha256 "af6b05ecb8df2c27a61ee3bbdd0103a5c7fc0bdbaa7cfc956a1efb97f49b6d60"
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
