class Xcresultparser@1.2.1 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.2.1"
  url "https://github.com/a7ex/xcresultparser/archive/1.2.1.tar.gz"
  sha256 "8d79b28262ae313265a05141a65e4aa9b290045ed914fd5333e1e4fa82cf48c2"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end