class Newc < Formula
  desc "GUI-driven C project scaffolding and management tool (CLI)"
  homepage "https://github.com/TheHomelessTwig/newc-rs"
  url "https://github.com/TheHomelessTwig/newc-rs/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "73fc3734e070dcf8b12c81027a960f35e56fdae71196802916d2a3429f817ae7"
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
