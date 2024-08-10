class XcresultparserAT116 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.1.6"
  url "https://github.com/a7ex/xcresultparser/archive/1.1.6.tar.gz"
  sha256 "7d5224fada9144449557cadbbd45699d7543262787cdc91b9a8c7d62dd9c6023"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end
