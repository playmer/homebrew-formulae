class Xcresultparser < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.7.2"
  url "https://github.com/a7ex/xcresultparser/archive/1.7.2.tar.gz"
  sha256 "6e8683cf6c39ead511d529c23914efca58a1c15c51dec9f6528b16e53af98fc5"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end
