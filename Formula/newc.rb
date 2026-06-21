class Newc < Formula
  desc "GUI-driven C project scaffolding and management tool"
  homepage "https://github.com/TheHomelessTwig/newc-rs"
  url "https://github.com/TheHomelessTwig/newc-rs/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "73fc3734e070dcf8b12c81027a960f35e56fdae71196802916d2a3429f817ae7"
  license "MIT"
  head "https://github.com/TheHomelessTwig/newc-rs.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "newc")
  end

  def post_install
    return unless OS.mac?

    app = Pathname.new("/Applications/newc.app")
    (app/"Contents/MacOS").mkpath
    (app/"Contents/Resources").mkpath
    cp buildpath/"packaging/Info.plist", app/"Contents/Info.plist"
    ln_sf bin/"newc", app/"Contents/MacOS/newc"

    icon_png = buildpath/"packaging/newc.png"
    icns = generate_icns(icon_png)
    if icns
      cp icns, app/"Contents/Resources/newc.icns"
    else
      opoo "newc.app installed without an icon (icon generation failed — see above)."
    end
  end

  # Render the pre-rendered packaging/newc.png (1024x1024) to a .icns using
  # only `sips` (resize) and `iconutil` (pack) — no `qlmanage`, since SVG
  # rasterisation via qlmanage needs a WindowServer connection that isn't
  # available inside Homebrew's sandboxed install environment (it exits 0
  # but silently produces no thumbnail there).
  # Returns the path to the generated .icns, or nil if any step fails.
  def generate_icns(png)
    unless which("sips") && which("iconutil")
      opoo "sips/iconutil not found — skipping icon generation."
      return nil
    end
    unless png.exist?
      opoo "#{png} not found — skipping icon generation."
      return nil
    end

    Dir.mktmpdir do |tmp|
      iconset = Pathname.new(tmp)/"newc.iconset"
      iconset.mkpath
      [16, 32, 64, 128, 256, 512, 1024].each do |sz|
        system "sips", "-z", sz.to_s, sz.to_s, png.to_s, "--out", "#{tmp}/#{sz}.png"
      end
      {
        16 => ["icon_16x16.png"],
        32 => ["icon_16x16@2x.png", "icon_32x32.png"],
        64 => ["icon_32x32@2x.png"],
        128 => ["icon_128x128.png"],
        256 => ["icon_128x128@2x.png", "icon_256x256.png"],
        512 => ["icon_256x256@2x.png", "icon_512x512.png"],
        1024 => ["icon_512x512@2x.png"],
      }.each do |sz, names|
        names.each { |n| cp "#{tmp}/#{sz}.png", iconset/n }
      end

      icns_out = Pathname.new(tmp)/"newc.icns"
      system "iconutil", "-c", "icns", iconset.to_s, "-o", icns_out.to_s
      return nil unless icns_out.exist?

      final = buildpath/"newc.icns"
      cp icns_out, final
      final
    end
  end

  def caveats
    return "" unless OS.mac?

    <<~EOS
      A standalone launcher was installed to /Applications/newc.app
      (wraps this same binary — opens the GUI from Launchpad/Spotlight,
      the CLI still works as `newc` from any shell).
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/newc --version")
  end
end
