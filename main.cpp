#include<Vtop.h>
#include<verilated.h>
#include<cstdio>
#include<cstdint>
Vtop *top;
void dut_single_cycle(){
    top -> clk = 0;
    top->eval();
    top -> clk = 1;
    top->eval();
}

int check_regs(uint8_t *dut_ptr, uint8_t *ref_ptr)
{
    bool is_diff = 0;

    for (int i = 0; i < 4; i++) {
        if (dut_ptr[i] != ref_ptr[i]) {
            printf("r%d different\n", i);
            is_diff = 1;
        }
    }

    return is_diff;
}
uint8_t *ref_get_regs();
void ref_inst_cycle ();
int main(int argc,char** argv){
    Verilated::commandArgs(argc, argv);

    Vtop dut;
    top = &dut;

    
    top->rst = 1;
    dut_single_cycle();
    top->rst = 0;
    int step = 0;
    while (step<40) {
  dut_single_cycle();
  ref_inst_cycle();
  uint8_t dut_regs[4] = {top->debug_r0,top->debug_r1,top->debug_r2,top->debug_r3};
  uint8_t *ref_regs = ref_get_regs();
  int is_diff = check_regs(dut_regs, ref_regs);
  if (is_diff) {
    std::printf("GPR different\n");
    std::printf("Simulation stop\n");
    top -> final();
    return 1;
  }
  step ++;
  
}
top -> final();
  return 0;
}