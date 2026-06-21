class Newc < Formula
  desc "GUI-driven C project scaffolding and management tool"
  homepage "https://github.com/TheHomelessTwig/newc-rs"
  url "https://github.com/TheHomelessTwig/newc-rs/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "ca8a2e20752e4308650dd1164f255f5c4555bfc76822606f637570a361975d90"
  license "MIT"
  head "https://github.com/TheHomelessTwig/newc-rs.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "newc")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/newc --version")
  end
end
