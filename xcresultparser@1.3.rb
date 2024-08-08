class XcresultparserAT1.3 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.3"
  url "https://github.com/a7ex/xcresultparser/archive/1.3.tar.gz"
  sha256 "32872e7e41c96a834909805d3b07b4d9bcb5251bef9caf60c06ecac8ac87e7f8"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end