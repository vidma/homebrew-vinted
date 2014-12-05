require 'formula'

class CdhPig < Formula
  homepage 'http://www.cloudera.com'
  url 'http://archive.cloudera.com/cdh5/cdh/5/pig-0.12.0-cdh5.2.1.tar.gz'
  sha1 'b07b1cdf4f66c269e520da04425ab271c9307cbd'
  version '0.12.0-cdh5.2.1'

  patch :DATA

  def install
    bin.install 'bin/pig'
    prefix.install ["pig-#{version}.jar", "pig-#{version}-withouthadoop.jar"]
  end

  def caveats; <<-EOS.undent
    You may need to set JAVA_HOME:
      export JAVA_HOME="$(/usr/libexec/java_home)"
    EOS
  end
end

# There's something weird with Pig's launch script, it doesn't find the correct
# path. This patch finds PIG_HOME from the pig binary path's symlink.
__END__
diff -u a/bin/pig b/bin/pig
--- a/bin/pig 2011-09-30 08:55:58.000000000 +1000
+++ b/bin/pig 2011-11-28 11:18:36.000000000 +1100
@@ -55,11 +55,8 @@

 # resolve links - $0 may be a softlink
 this="${BASH_SOURCE-$0}"
-
-# convert relative path to absolute path
-bin=$(cd -P -- "$(dirname -- "$this")">/dev/null && pwd -P)
-script="$(basename -- "$this")"
-this="$bin/$script"
+here=$(dirname $this)
+this="$here"/$(readlink $this)

 # the root of the Pig installation
 export PIG_HOME=`dirname "$this"`/..
