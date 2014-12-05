require 'formula'

class CdhHive < Formula
  homepage 'http://hive.apache.org'
  url 'http://archive.cloudera.com/cdh5/cdh/5/hive-0.13.1-cdh5.2.1.tar.gz'
  sha1 'ca3d24c2f4c61c6eec3eefe49c36f4c12702494a'

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
