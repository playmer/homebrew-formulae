class Xcresultparser@1.1.3 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.1.3"
  url "https://github.com/a7ex/xcresultparser/archive/1.1.3.tar.gz"
  sha256 "ce4bd863eea765fa3b7e8eaa2fb239b938ef8c4e0d73354bb943c45c971ddf56"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end