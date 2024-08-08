class XcresultparserAT1.5.1 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.5.1"
  url "https://github.com/a7ex/xcresultparser/archive/1.5.1.tar.gz"
  sha256 "cfab4b6fce0c36e9e66f98f0ea16bfb723151bc81c5c96d8309184c15e55ebf7"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end