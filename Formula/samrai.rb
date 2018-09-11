# Documentation: https://docs.brew.sh/Formula-Cookbook
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Samrai < Formula
  desc "Structured Adaptive Mesh Refinement Application Infrastructure"
  homepage "https://computation.llnl.gov/project/SAMRAI/"
  
  head "https://github.com/monwarez/SAMRAI.git", :branch => "add-install"
  url "https://github.com/monwarez/SAMRAI.git" 
  version "1.0-random"
  depends_on "cmake" => :build
  depends_on "openmpi"
  depends_on "libomp"
  depends_on "hdf5" => "--with-mpi"
  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    system "git", "fetch", "origin", "add-install:add-install"
    system "git", "checkout", "add-install"
    system "git", "submodule", "init"
    system "git", "submodule", "update"
    system "mkdir", "build"
    ENV["CC"] = "mpicc"
    ENV["CXX"] = "mpicxx"
    ENV["FC"] = "mpif90"
    ENV["F77"] = "mpif77"
    system "cmake", "-DENABLE_OPENMP=false", "-DENABLE_COPY_HEADERS=ON", "-DCMAKE_BUILD_TYPE=Release", "-Bbuild", "-H.", *std_cmake_args
    system "make", "-C", "build", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test SAMRAI`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
