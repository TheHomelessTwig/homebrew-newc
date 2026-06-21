class Newc < Formula
  desc "GUI-driven C project scaffolding and management tool (CLI)"
  homepage "https://github.com/TheHomelessTwig/newc-rs"
  url "https://github.com/TheHomelessTwig/newc-rs/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "934d466b3370f28560c821e747f6d23a85c5f9dbefe40dfdf4ef1d07bd00b0d0"
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
