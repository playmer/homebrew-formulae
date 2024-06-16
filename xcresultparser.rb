class Xcresultparser < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.6.4"
  url "https://github.com/a7ex/xcresultparser/archive/1.6.4.tar.gz"
  sha256 "d6cdb30c6bc99950cdfaddcc5e12a8d3c138ff22db2318f733395fa22b0b47e8"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end
