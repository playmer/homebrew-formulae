class XcresultparserAT131 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.3.1"
  url "https://github.com/a7ex/xcresultparser/archive/1.3.1.tar.gz"
  sha256 "8a4ea2f17d7cbcef24591007bb89f886de29527989047a0e049649aee331d17d"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end
