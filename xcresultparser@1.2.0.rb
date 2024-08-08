class Xcresultparser@1.2.0 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.2.0"
  url "https://github.com/a7ex/xcresultparser/archive/1.2.0.tar.gz"
  sha256 "08e27525c8d32e0233b9a2afa332f38d8dc2098920429c99c0930804243888c7"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end