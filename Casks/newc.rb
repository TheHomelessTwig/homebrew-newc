cask "newc" do
  version "1.0.3"
  sha256 "27ad56263cda30138ef8441112838bb9d49e3b3da6777cd0f829cfbd933f50b2"

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
