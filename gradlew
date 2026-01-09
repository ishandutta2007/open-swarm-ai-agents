#!/usr/bin/env sh

#
# Copyright 2015 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# @author: Andres Almiray
#

#
# This script is an adaptation of a similar script found in the spring-boot-cli project.
#

#
# Environment Variable Prequisites
#
#   JAVA_HOME       Must point at your Java Development Kit installation.
#
#   GRADLE_OPTS     (Optional) Java runtime options used when running Gradle.
#
#   GRADLE_HOME     (Optional) Point to a Gradle installation. If not set, this
#                   script will use the Gradle wrapper.
#
#   JAVA_OPTS       (Optional) Java runtime options used when running Gradle.
#                   Will be overriden by GRADLE_OPTS.
#
#   DEBUG           (Optional) If set, debugging messages will be printed.
#

#
# Sanity check
#
if [ -n "$DEBUG" ]; then
    echo "DEBUG: JAVA_HOME = $JAVA_HOME"
    echo "DEBUG: GRADLE_HOME = $GRADLE_HOME"
    echo "DEBUG: GRADLE_OPTS = $GRADLE_OPTS"
    echo "DEBUG: JAVA_OPTS = $JAVA_OPTS"
fi

#
# OS specific support.  $var _must_ be set to either true or false.
#
cygwin=false
msys=false
darwin=false
case "`uname`" in
  CYGWIN*) cygwin=true;;
  Darwin*) darwin=true;;
  MINGW*) msys=true;;
esac

#
# For Cygwin, ensure paths are in UNIX format before anything is touched
#
if $cygwin ; then
  [ -n "$JAVA_HOME" ] && JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
  [ -n "$GRADLE_HOME" ] && GRADLE_HOME=`cygpath --unix "$GRADLE_HOME"`
fi

#
# Attempt to set JAVA_HOME if it is not already set
#
if [ -z "$JAVA_HOME" ] ; then
  if $darwin ; then
    [ -x '/usr/libexec/java_home' ] && export JAVA_HOME=`/usr/libexec/java_home`
  else
    java_executable=`which java`
    [ -z "$java_executable" ] && {
      echo "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH."
      echo
      echo "Please set the JAVA_HOME variable in your environment to match the"
      echo "location of your Java installation."
      exit 1
    }
    # Follow symlinks
    if [ -L "$java_executable" ]; then
        java_executable=`readlink -f "$java_executable"`
    fi
    java_directory=`dirname "$java_executable"`
    JAVA_HOME=`dirname "$java_directory"`
  fi
fi

#
# If GRADLE_HOME is not set, try to determine it based on the script's location
#
if [ -z "$GRADLE_HOME" ] ; then
  ## resolve links - $0 may be a softlink
  PRG="$0"
  while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
      PRG="$link"
    else
      PRG=`dirname "$PRG"`/"$link"
    fi
  done
  GRADLE_HOME=`dirname "$PRG"`

  #
  # For Cygwin, switch paths to Windows format before running java
  #
  if $cygwin; then
    JAVA_HOME=`cygpath --path --windows "$JAVA_HOME"`
    GRADLE_HOME=`cygpath --path --windows "$GRADLE_HOME"`
  fi
fi

#
# Set GRADLE_OPTS from JAVA_OPTS if not already set
#
if [ -z "$GRADLE_OPTS" ]; then
    GRADLE_OPTS="$JAVA_OPTS"
fi

#
# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass
# JVM options to this script.
#
DEFAULT_JVM_OPTS="-Xmx64m -Xms64m"

#
# Collect all arguments for the java command, following the shell quoting and
# word splitting rules.
#
eval set -- "$DEFAULT_JVM_OPTS $GRADLE_OPTS" '"-Dorg.gradle.appname=$APP_NAME"' -classpath '"$GRADLE_HOME/lib/*"' org.gradle.wrapper.GradleWrapperMain "$@"

#
# Run Gradle
#
exec "$JAVA_HOME/bin/java" "$@"
