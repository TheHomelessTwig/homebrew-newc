cask "newc" do
  version "0.0.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/TheHomelessTwig/newc-rs/releases/download/v#{version}/newc-aarch64-macos.app.zip"
  name "newc"
  desc "GUI-driven C project scaffolding and management tool"
  homepage "https://github.com/TheHomelessTwig/newc-rs"

  depends_on arch: :arm64
  depends_on macos: ">= :big_sur"

  app "newc.app"

  zap trash: [
    "~/Library/Application Support/newc",
  ]
end
