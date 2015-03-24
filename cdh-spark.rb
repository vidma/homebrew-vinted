require "formula"

class CdhSpark < Formula
  homepage "http://spark.apache.org/"
  head "https://github.com/cloudera/spark.git"
  url "https://vinted-analytics.s3.amazonaws.com/spark-1.3.0-bin-spark-1.3.tgz"
  version "1.3.0-cdh5.3.2"
  sha1 "6d656c3e50d676b2b2b1afb71bbabaf58903ab3c"

  conflicts_with 'hive', :because => 'both install `beeline` binaries'

  def install
    rm_f Dir["bin/*.cmd"]
    libexec.install Dir["*"]
    bin.write_exec_script Dir["#{libexec}/bin/*"]
  end

  test do
    system "#{bin}/spark-shell <<<'sc.parallelize(1 to 1000).count()'"
  end
end
