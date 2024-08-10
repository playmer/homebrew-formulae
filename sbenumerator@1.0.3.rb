class SbenumeratorAT103 < Formula
  desc "Parse Xcode Interface Builder files and create enums for cell identifiers and accessibility identifiers"
  homepage "https://github.com/a7ex/SBEnumerator"
  version "1.0.3"
  url "https://github.com/a7ex/SBEnumerator/archive/1.0.3.tar.gz"
  sha256 "6fb75774fb96423560e062eed832ac47326a79fab3d03cd50b5c9f8ec8734c9a"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Error: Argument error. No Interface Builder file was provided. Use --help for a usage description.", shell_output("#{bin}/sbenumerator")
  end

end
