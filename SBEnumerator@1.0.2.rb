class SbenumeratorAT102 < Formula
  desc "Parse Xcode Interface Builder files and create enums for cell identifiers and accessibility identifiers"
  homepage "https://github.com/a7ex/SBEnumerator"
  version "1.0.2"
  url "https://github.com/a7ex/SBEnumerator/archive/1.0.2.tar.gz"
  sha256 "3c53dc86acd0d8a3f90c60a24c9d946cb29ce3438d8be694974e42974ae50589"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Error: Argument error. No Interface Builder file was provided. Use --help for a usage description.", shell_output("#{bin}/sbenumerator")
  end

end