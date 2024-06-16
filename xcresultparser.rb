class Xcresultparser < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.6.3"
  url "https://github.com/a7ex/xcresultparser/archive/1.6.3.tar.gz"
  sha256 "69a5e1952a44a43cf99e4e4c8608c7b7a1d8972935c51cf66707c18ab14cdc09"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end
