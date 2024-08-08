class XcresultparserAT141 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.4.1"
  url "https://github.com/a7ex/xcresultparser/archive/1.4.1.tar.gz"
  sha256 "20fca44a96e43d4e596b2c6ea7ee77ab076a8bab765a945dac8b93bc8f9b58cf"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end