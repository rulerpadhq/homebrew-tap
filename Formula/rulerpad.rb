class Rulerpad < Formula
  desc "Managed run and continuity layer for coding agents"
  homepage "https://rulerpad.com"
  version "0.1.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://dl.rulerpad.com/v1/archives/v0.1.0/rulerpad-v0.1.0-macos-aarch64.tar.gz"
      sha256 "fce1c31cf37feeac059043339f36ebb325d2aec9ca2f579a8e336d81aba49b7f"
    end
    on_intel do
      url "https://dl.rulerpad.com/v1/archives/v0.1.0/rulerpad-v0.1.0-macos-x86_64.tar.gz"
      sha256 "fff19afa25c983f520f920dc280e997673770c728363203f5799b812bc0636cf"
    end
  end
  on_linux do
    on_arm do
      url "https://dl.rulerpad.com/v1/archives/v0.1.0/rulerpad-v0.1.0-linux-aarch64.tar.gz"
      sha256 "c11a7d87cdd1818a1ec25dca637a6a3581878544887ba686f88dbf9eb382540b"
    end
    on_intel do
      url "https://dl.rulerpad.com/v1/archives/v0.1.0/rulerpad-v0.1.0-linux-x86_64.tar.gz"
      sha256 "51feeda96280a5df758d5b09ebf7745bd183defc3fcc6289342d485289f4b92c"
    end
  end

  def install
    bin.install "bin/rulerpad"
    libexec.install Dir["libexec/*"]
    chmod 0755, libexec/"shims/claude"
  end

  def caveats
    <<~EOS
      Rulerpad keeps its shims and shell integration private in:
        #{opt_libexec}/shims
        #{opt_libexec}/shell-integration
      They are added to Rulerpad's own panes only, never to your global PATH.
    EOS
  end

  test do
    assert_match "rulerpad", shell_output("#{bin}/rulerpad --version")
    assert_predicate libexec/"rulerpad-ui", :exist?
    assert_predicate libexec/"shims/claude", :executable?
    assert_predicate libexec/"shell-integration/manifest.json", :exist?
    assert_predicate libexec/"shell-integration/zsh/.zshenv", :exist?
    assert_predicate libexec/"shell-integration/bash/rulerpad.bash", :exist?
  end
end
