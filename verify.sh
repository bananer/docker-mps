#!/bin/bash
assert_file() {
    if [ ! -f $1 ]; then
        echo "Missing file: $1"
        exit 1;
    fi
}

assert_file "/mps/bin/mps.sh"
assert_file "/mps/bin/mac/Contents/MacOS/mps"
assert_file "/mps/bin/win/mps.bat"
assert_file "/mps/build.properties"
assert_file "/mps/languages/baseLanguage/jetbrains.mps.baseLanguage.jar"
assert_file "/mps/lib/mps-core.jar"
assert_file "/mps/plugins/mps-core/lib/mps-core.jar"

assert_file "/jre/osx/jbr/Contents/Home/bin/java"
assert_file "/jre/osx/jbr/Contents/Home/bin/javac"

assert_file "/jre/win/jbr/bin/java"
assert_file "/jre/win/jbr/bin/javac"
