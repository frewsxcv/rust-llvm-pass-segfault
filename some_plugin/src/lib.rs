#![feature(plugin_registrar, rustc_private)]

extern crate rustc;
extern crate rustc_plugin;

use rustc_plugin::registry::Registry;

#[plugin_registrar]
pub fn plugin_registrar(reg: &mut Registry) {
    reg.register_llvm_pass("some-llvm-pass");
}
