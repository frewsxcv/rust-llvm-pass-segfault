#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "llvm/IR/Module.h"

using namespace llvm;

namespace {

  class TestLLVMPass : public ModulePass {

  public:

    static char ID;
    TestLLVMPass() : ModulePass(ID) { }

    bool runOnModule(Module &M) override;

    const char *getPassName() const override {
      return "Some LLVM pass";
    }

  };

}

bool TestLLVMPass::runOnModule(Module &M) {
  /* segmentation fault happens here */
  for (auto F = M.begin(); F != M.end(); ++F) {
    /* code */
  }

  return true;
}

char TestLLVMPass::ID = 0;

static RegisterPass<TestLLVMPass> RegisterAFLPass(
  "some-llvm-pass", "Some LLVM pass");
