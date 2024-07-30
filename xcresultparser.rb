class Xcresultparser < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.7.1"
  url "https://github.com/a7ex/xcresultparser/archive/1.7.1.tar.gz"
  sha256 "46cc2bf801a7f45facecf4cd553ed1cc513c66651fd7a731f30bd94a606dc060"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end
