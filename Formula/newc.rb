class Newc < Formula
  desc "GUI-driven C project scaffolding and management tool (CLI)"
  homepage "https://github.com/TheHomelessTwig/newc-rs"
  url "https://github.com/TheHomelessTwig/newc-rs/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "14efa3417b51c57b98a5fc562040b0d49ff713d50a17fbbc9ccd62b8b2845d5c"
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
