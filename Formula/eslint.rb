require "language/node"

class Eslint < Formula
  desc "AST-based pattern checker for JavaScript"
  homepage "https://eslint.org"
  url "https://registry.npmjs.org/eslint/-/eslint-5.10.0.tgz"
  sha256 "517407fc056a46902fe86c5e0c2527b0f13f709a7a4c29a16398ab9190f1eb5d"

  bottle do
    cellar :any_skip_relocation
    sha256 "2e64dc86bd8f278da176017788f158e6b9ffdf3da70a5049e0bb22f1cf7de8ec" => :mojave
    sha256 "cbd6ddc2428df02d64beb4f9b17939b6d3015e33a0e5a71cf110d1a5959e4266" => :high_sierra
    sha256 "15bf70aba3a74355304f527850de2e617dcbfe5c4b4d0b787c111ad3628d9939" => :sierra
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/".eslintrc.json").write("{}") # minimal config
    (testpath/"syntax-error.js").write("{}}")
    # https://eslint.org/docs/user-guide/command-line-interface#exit-codes
    output = shell_output("#{bin}/eslint syntax-error.js", 1)
    assert_match "Unexpected token }", output
  end
end
