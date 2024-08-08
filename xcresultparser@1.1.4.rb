class XcresultparserAT1.1.4 < Formula
  desc "Parse .xcresult files and print summary in different formats"
  homepage "https://github.com/a7ex/xcresultparser"
  version "1.1.4"
  url "https://github.com/a7ex/xcresultparser/archive/1.1.4.tar.gz"
  sha256 "765eaffe976ce917837ed9214483e4103c43f138788fb1ea68e04f2bb736f114"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Missing expected argument '<xcresult-file>'", shell_output("#{bin}/xcresultparser -o txt")
  end

end