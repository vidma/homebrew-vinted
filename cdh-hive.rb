require 'formula'

class CdhHive < Formula
  homepage 'http://hive.apache.org'
  url 'http://archive.cloudera.com/cdh5/cdh/5/hive-0.13.1-cdh5.3.0.tar.gz'
  sha1 '4c62a1d6638fe5958cda8c2d4be2cf704845e502'

  depends_on 'hadoop'

  def install
    rm_f Dir["bin/*.bat"]
    libexec.install %w[bin conf examples hcatalog lib scripts]
    bin.write_exec_script Dir["#{libexec}/bin/*"]
  end

  def caveats; <<-EOS.undent
    Hadoop must be in your path for hive executable to work.
    After installation, set $HIVE_HOME in your profile:
      export HIVE_HOME=#{libexec}

    If you want to use HCatalog with Pig, set $HCAT_HOME in your profile:
      export HCAT_HOME=#{libexec}/hcatalog

    You may need to set JAVA_HOME:
      export JAVA_HOME="$(/usr/libexec/java_home)"
    EOS
  end
end
