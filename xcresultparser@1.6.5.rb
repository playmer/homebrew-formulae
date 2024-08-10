class XcresultparserAT165 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.6.5"
  url "https://github.com/a7ex/xcresultparser/archive/1.6.5.tar.gz"
  sha256 "7e354bd2d0d2958df748727ebac6e2357a3afb2689b33780cba429f0bfa8771a"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end
