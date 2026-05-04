class Brr < Formula
  desc "Draft your swarm"
  homepage "https://spacebrr.com"
  version "0.3.48"
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
      url "https://releases.spacebrr.com/v0.3.48/brr-darwin-arm64"
      sha256 "b430ca47feabe03634b3d35f13fc9f03d42536abaa4a87ded012262ce647df53"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.48/brr-daemon-darwin-arm64"
        sha256 "b91b8ee534b9da75a13359e384b04bb3b46272f5bed2fb422a204aa0554053ce"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.48/brr-spawn-darwin-arm64"
        sha256 "bbde93cf76ff5c9cb86c3ee74bc0bdf8454f20edb7a1be7ee77d6f5bd645929a"
      end
    else
      url "https://releases.spacebrr.com/v0.3.48/brr-darwin-amd64"
      sha256 "ddfd4a5ddaae70389ec9daaa9976709fc0fbcae1ebefe4ac4166403928943909"

      resource "brr-daemon" do
        url "https://releases.spacebrr.com/v0.3.48/brr-daemon-darwin-amd64"
        sha256 "1b8a3cfd2446887a5ff8bb91a81e1a8122383cc0ee09d225b3b0b4386a4d7386"
      end

      resource "brr-spawn" do
        url "https://releases.spacebrr.com/v0.3.48/brr-spawn-darwin-amd64"
        sha256 "261ecd46c497dff2fe1d024f09a923f87d1c1442da5e18561e308a51b17a506a"
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
