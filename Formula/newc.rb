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

  def post_install
    return unless OS.mac?

    app = Pathname.new("/Applications/newc.app")
    (app/"Contents/MacOS").mkpath
    (app/"Contents/Resources").mkpath
    cp buildpath/"packaging/Info.plist", app/"Contents/Info.plist"
    ln_sf bin/"newc", app/"Contents/MacOS/newc"

    icon_svg = buildpath/"packaging/newc.svg"
    icns = generate_icns(icon_svg)
    cp icns, app/"Contents/Resources/newc.icns" if icns
  end

  # Render packaging/newc.svg to a .icns using only stock macOS tools
  # (qlmanage for SVG rasterisation, sips to resize, iconutil to pack).
  # Returns the path to the generated .icns, or nil if any step is unavailable.
  def generate_icns(svg)
    return nil unless which("qlmanage") && which("iconutil") && svg.exist?

    Dir.mktmpdir do |tmp|
      system "qlmanage", "-t", "-s", "1024", "-o", tmp, svg.to_s
      png = Pathname.new(tmp)/"newc.svg.png"
      return nil unless png.exist?

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
