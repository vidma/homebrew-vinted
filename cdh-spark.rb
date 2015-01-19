require "formula"

class CdhSpark < Formula
  homepage "http://spark.apache.org/"
  head "https://github.com/cloudera/spark.git"
  url "https://vinted-analytics.s3.amazonaws.com/spark-1.2.0-cdh5.3.0.tgz"
  version "1.2.0-cdh5.3.0"
  sha1 "43d93663625afcb48c6b171e23739a46bf84e809"

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
