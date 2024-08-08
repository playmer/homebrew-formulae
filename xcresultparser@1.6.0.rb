class XcresultparserAT1.6.0 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.6.0"
  url "https://github.com/a7ex/xcresultparser/archive/1.6.0.tar.gz"
  sha256 "7e25017096d0203891dd6751d8ba555e45cd562769bd10cee4dc9bb6073dff43"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end