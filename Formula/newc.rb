class Newc < Formula
  desc "GUI-driven C project scaffolding and management tool"
  homepage "https://github.com/TheHomelessTwig/newc-rs"
  url "https://github.com/TheHomelessTwig/newc-rs/archive/refs/tags/v0.8.1.tar.gz"
  sha256 "29f7039c51204018ccc326d39e353a6bce328388f8c0a4ec849af169c5f2de6a"
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
