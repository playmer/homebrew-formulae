class XcresultparserAT101 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.0.1"
  url "https://github.com/a7ex/xcresultparser/archive/1.0.1.tar.gz"
  sha256 "1aa107fcfe499fa7c9b6d5ff816a6fa412b3839cb67bb85d823d1e84ee655d39"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end