class XcresultparserAT140 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.4.0"
  url "https://github.com/a7ex/xcresultparser/archive/1.4.0.tar.gz"
  sha256 "b3c9a1c4c6375852b60087622653b0f486917cc8f945c605be3ca24f5f7af21a"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end