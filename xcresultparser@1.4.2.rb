class XcresultparserAT142 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.4.2"
  url "https://github.com/a7ex/xcresultparser/archive/1.4.2.tar.gz"
  sha256 "e0a1d07e62cabc319fb8ac6f9fc744ac46ecc7529b8f398a68688eb2746e0a46"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end
