class Qhull < Formula
  desc "Computes convex hulls in n dimensions"
  homepage "http://www.qhull.org/"
  url "http://www.qhull.org/download/qhull-2020-src-8.0.2.tgz"
  version "2020.2"
  sha256 "b5c2d7eb833278881b952c8a52d20179eab87766b00b865000469a45c1838b7e"
  license "Qhull"
  head "https://github.com/qhull/qhull.git"

  # It's necessary to match the version from the link text, as the filename
  # only contains the year (`2020`), not a full version like `2020.2`.
  livecheck do
    url "http://www.qhull.org/download/"
    regex(/href=.*?qhull[._-][^"' >]+?[._-]src[^>]*?\.t[^>]+?>[^<]*Qhull v?(\d+(?:\.\d+)*)/i)
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "70ad8528bfc11ba315d21927b68d48edc0500ec3d2aa5d671ffafaded1311573"
    sha256 cellar: :any, big_sur:       "4184d2e81f587b29b20f1b116862c2311dbcb46c37e0067bb9a670cf30dedbf2"
    sha256 cellar: :any, catalina:      "45f8b6efc0a77e4fd613ef527d6c55545908f860106d4355bd753ad07a934bd1"
    sha256 cellar: :any, mojave:        "61a2fab7f2854401bdffe54b889a1e2b9d90f6a11e52aba80688875b8f7d08a5"
    sha256 cellar: :any, high_sierra:   "36e0e4a621e0c89746584562634768ccb93e71fc500230133620db030b1cc05a"
  end

  depends_on "cmake" => :build

  def install
    ENV.cxx11

    cd "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    input = shell_output(bin/"rbox c D2")
    output = pipe_output("#{bin}/qconvex s n 2>&1", input, 0)
    assert_match "Number of facets: 4", output
  end
end
