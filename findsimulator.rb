class Findsimulator < Formula
  desc "Compute 'destination' for xcodebuild command line tool to build Xcode projects."
  homepage "https://github.com/a7ex/findsimulator"
  version "0.3.0"
  url "https://github.com/a7ex/findsimulator/archive/0.3.tar.gz"
  sha256 "9389387a20173180d1e91cc8e1edeebea48438aeff6df04ab0714b9b86a414be"
  license "MIT"

  depends_on xcode: ["10.0", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    assert_match "0.3", shell_output("#{bin}/findsimulator -v")
  end

end
