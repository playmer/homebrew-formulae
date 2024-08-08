class XcresultparserAT150 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.5.0"
  url "https://github.com/a7ex/xcresultparser/archive/1.5.0.tar.gz"
  sha256 "8830b6507d174648ddcd28402d381c13d605c83856db140b4d6a494fc856ad47"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end