set -e

: ${CXX:=g++}
: ${AR:=ar}
# $OUT_DIR is set by Cargo

if [ "$LLVM_CONFIG" == "" ]; then
    echo '[*] $LLVM_CONFIG not set. Will assume you built rustc from source.'
    LLVM_CONFIG=$(find $(dirname $(which rustc))/../.. -name llvm-config -type f | head -n 1)
fi

if ! [ -x "$LLVM_CONFIG" ]; then
    echo "[-] Expected but did not find llvm-config at $LLVM_CONFIG"
    exit 1
fi

set -x

CXXFLAGS="$($LLVM_CONFIG --cxxflags) -g -fPIC -Wall -Werror -fno-rtti"

$CXX $CXXFLAGS -c src/llvm-pass.cc -o $OUT_DIR/llvm-pass.o
$AR rcs $OUT_DIR/libllvm-pass.a $OUT_DIR/llvm-pass.o
