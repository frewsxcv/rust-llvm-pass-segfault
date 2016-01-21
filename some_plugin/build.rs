use std::process::Command;
use std::env;

fn main() {
    assert!(Command::new("bash").arg("build.bash").status().unwrap().success());
    println!("cargo:rustc-link-search=native={}", env::var("OUT_DIR").unwrap());
    println!("cargo:rustc-link-lib=static=llvm-pass");
}
