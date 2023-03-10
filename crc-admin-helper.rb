class CrcAdminHelper < Formula
  desc "setuid helper used by crc"
  homepage "https://github.com/crc-org/admin-helper"
  url "https://github.com/crc-org/admin-helper.git",
      tag: "v0.0.12",
      revision: "dca192011f94b2888e1cb2e6256a3cb22a27dea5"
  license "Apache-2.0"
  head "https://github.com/crc-org/admin-helper.git", branch: "master"

  depends_on "go" => :build

  def install
    system "make", "all"
    bin.install "crc-admin-helper"
  end

  def caveats
    <<~EOS
      This crc helper requires superuser privileges to modify the /etc/hosts file. To
      enable, execute:
        sudo chown root:wheel #{opt_bin}/crc-admin-helper
        sudo chmod u+s #{opt_bin}/crc-admin-helper
    EOS
  end

  test do
    # test version
    version_output = shell_output("#{bin}/crc-admin-helper --version 2>&1").strip
    assert_match(/admin-helper version #{version}/, version_output)

    # check for the presence of a non existing hostname
    assert_equal("false", shell_output("#{bin}/crc-admin-helper contains brew-test.example.com 1.2.3.4").strip)
  end
end

