# homebrew-newc

Homebrew tap for [newc](https://github.com/TheHomelessTwig/newc-rs), a GUI-driven C project scaffolding and management tool.

## Install

```bash
brew tap thehomelesstwig/newc
brew install newc
```

## Updating the formula on release

This formula builds from source (`cargo install`), so each new `newc-rs` release tag needs:

1. Bump `url` to the new tag.
2. Recompute `sha256`:
   ```bash
   curl -fsSL https://github.com/TheHomelessTwig/newc-rs/archive/refs/tags/vX.Y.Z.tar.gz | sha256sum
   ```
3. Commit and push.
