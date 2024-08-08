class SbenumeratorAT101 < Formula
  desc "Parse Xcode Interface Builder files and create enums for cell identifiers and accessibility identifiers"
  homepage "https://github.com/a7ex/SBEnumerator"
  version "1.0.1"
  url "https://github.com/a7ex/SBEnumerator/archive/1.0.1.tar.gz"
  sha256 "6554d0e6ca47f77e3c6097281aff9a7f711841c2b682719e93b6b3f5af07751a"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Error: Argument error. No Interface Builder file was provided. Use --help for a usage description.", shell_output("#{bin}/sbenumerator")
  end

end