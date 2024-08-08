class XcresultparserAT1.6.1 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.6.1"
  url "https://github.com/a7ex/xcresultparser/archive/1.6.1.tar.gz"
  sha256 "5e2be3e7b189513ce4a6824e703c538799f9e9c4580b395711525415ae460e15"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end