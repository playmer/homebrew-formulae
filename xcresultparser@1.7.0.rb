class Xcresultparser@1.7.0 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.7.0"
  url "https://github.com/a7ex/xcresultparser/archive/1.7.0.tar.gz"
  sha256 "0cfcd67d4cd5510939bf89bd2e8eca1b6256be8fd35aa4555578a45091f28d02"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end