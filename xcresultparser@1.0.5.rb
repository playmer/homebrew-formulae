class XcresultparserAT105 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.0.5"
  url "https://github.com/a7ex/xcresultparser/archive/1.0.5.tar.gz"
  sha256 "fd561e7f4c3c1dbaa034a34ce32f4788801426f29d63072c59e95786170812b8"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end
