cask "newc" do
  version "1.0.4"
  sha256 "a06ac6e3bc6631296c10c52c8d009779df68e9c9e2e3a3f70068aae268c0fd3a"

  url "https://github.com/TheHomelessTwig/newc-rs/releases/download/v#{version}/newc-aarch64-macos.app.zip"
  name "newc"
  desc "GUI-driven C project scaffolding and management tool"
  homepage "https://github.com/TheHomelessTwig/newc-rs"

  depends_on arch: :arm64
  depends_on macos: ":big_sur"

  app "newc.app"

  zap trash: [
    "~/Library/Application Support/newc",
  ]
end
