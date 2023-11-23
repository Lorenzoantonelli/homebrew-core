class Sshuttle < Formula
  desc "Proxy server that works as a poor man's VPN"
  homepage "https://sshuttle.readthedocs.io/en/stable/"
  url "https://files.pythonhosted.org/packages/f1/4d/91c8bff8fabe44cd88edce0b18e874e60f1e11d4e9d37c254f2671e1a3d4/sshuttle-1.1.1.tar.gz"
  sha256 "f5a3ed1e5ab1213c7a6df860af41f1a903ab2cafbfef71f371acdcff21e69ee6"
  license "LGPL-2.1-or-later"
  head "https://github.com/sshuttle/sshuttle.git", branch: "master"

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "deba85af358f85a3134b352ebac8c18bebc83971555c669384f64fa51c87de0f"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1dbcd6db39b8015e73a3e0c61880eac8aca2e8098298308c9f4efcc56a54d652"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dff16521a17e20afdcf509f3c08dba37683b6b6f025ecbbf07445e15f810e4e1"
    sha256 cellar: :any_skip_relocation, sonoma:         "311da73f302215fefbce07a4cbd8dbb655416837f69d9ce2a8947c15a18cc089"
    sha256 cellar: :any_skip_relocation, ventura:        "06c3cf2fd8ab98f82fd8ff2fb62ce8402e3fff5bfdbf0578d0552ce86caa85b6"
    sha256 cellar: :any_skip_relocation, monterey:       "f1d20a62e3ea7794b9de39a4126970bc2460a3e6422e1870d24d41acc9b86bc8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "10ee215511c9e5d6dc9d8877715682c4d26177a642b7fcf7777a941a48edf0c3"
  end

  depends_on "python-setuptools" => :build
  depends_on "python@3.12"

  def python3
    "python3.12"
  end

  def install
    system python3, "-m", "pip", "install", *std_pip_args, "."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sshuttle --version")

    # Could not remove python@3.12 keg!
    return if OS.linux? && ENV["HOMEBREW_GITHUB_ACTIONS"]

    output = shell_output("#{bin}/sshuttle --dns -r username@sshserver 0/0 2>&1", 99)
    assert_match "You must be root (or enable su/sudo) to set the firewall", output
  end
end
