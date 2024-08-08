class XcresultparserAT162 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.6.2"
  url "https://github.com/a7ex/xcresultparser/archive/1.6.2.tar.gz"
  sha256 "936673bbbab678b65cb8c2e805ac2c520e4db39ad95342c3c833dc2bbb442c42"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end