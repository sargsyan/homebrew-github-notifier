class GithubNotifier < Formula
  desc "Get Github and Github Enterprise notifications in your Mac OS "
  homepage "https://sargsyan.github.io/github-notifier/"
  url "https://github.com/sargsyan/github-notifier/archive/v1.0.2.tar.gz"
  sha256 "6ae1610c998362217b6eaeb14cf31c09d07ab6e16d3d62a62f359a622f26e1d7"

  depends_on "jq"

  def install
    bin.mkpath
    lib.install "install.sh"
    lib.install "uninstall.sh"
    lib.install "configure.sh"
    lib.install "constants.sh"
    lib.install "github_notif"
    lib.install "lib"
    lib.install "github-notifier.app"
    inreplace lib/"install.sh", /APPLICATION_DIR_ABSOLUTE_PATH=.*/, "APPLICATION_DIR_ABSOLUTE_PATH=#{lib}"
    inreplace lib/"uninstall.sh", /APPLICATION_DIR_ABSOLUTE_PATH=.*/, "APPLICATION_DIR_ABSOLUTE_PATH=#{lib}"
    inreplace lib/"configure.sh", /DIR_NAME=.*/, "DIR_NAME=#{lib}"
    ln_s lib/"install.sh", bin/"github-notifier-install"
    ln_s lib/"uninstall.sh", bin/"github-notifier-uninstall"
    ln_s lib/"configure.sh", bin/"github-notifier-configure"
  end

  def post_install
    system "github-notifier-install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test github-notifier`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
  end
end
