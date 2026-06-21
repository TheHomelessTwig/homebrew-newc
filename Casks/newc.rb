cask "newc" do
  version "1.0.5"
  sha256 "4c5d795c307250b32e938dbc177e1de2b02766774efe0f2507872a5d51c340e9"

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
