class XcresultparserAT122 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.2.2"
  url "https://github.com/a7ex/xcresultparser/archive/1.2.2.tar.gz"
  sha256 "7854c5e1d2ce5ec116aab11762422527b7e981aef4bf15321594a0f80d737bb0"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end
