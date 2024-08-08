class SbenumeratorAT100 < Formula
  desc "Parse Xcode Interface Builder files and create enums for cell identifiers and accessibility identifiers"
  homepage "https://github.com/a7ex/SBEnumerator"
  version "1.0.0"
  url "https://github.com/a7ex/SBEnumerator/archive/1.0.0.tar.gz"
  sha256 "b0e313aa3722b8e19260a122d312d63b061c2610d18ddeb68221b2ab9d605f14"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "Error: Argument error. No Interface Builder file was provided. Use --help for a usage description.", shell_output("#{bin}/sbenumerator")
  end

end