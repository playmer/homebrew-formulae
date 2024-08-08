class Xcresultparser@1.0 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.0"
  url "https://github.com/a7ex/xcresultparser/archive/1.0.tar.gz"
  sha256 "cf167f961a6b3f4767baf07cae395434633ac1872e978dc7a38e7721b33791f5"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end