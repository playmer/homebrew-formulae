class XcresultparserAT152 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.5.2"
  url "https://github.com/a7ex/xcresultparser/archive/1.5.2.tar.gz"
  sha256 "6b770f96d67295105cb6d13039be66de54513d773c47cfc766a380ca41f7882a"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end
