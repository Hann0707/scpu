#include<stdio.h>
#include<stdint.h>
#include <stdlib.h>
uint8_t PC = 0;
uint8_t R[4];
uint8_t M[256] = {0x8a, 0x90, 0xa0, 0xb1,
    0x17, 0x29, 0xd1, 0xdf};
int jump_pc = 0;
void ref_inst_cycle (){
    
    uint8_t addr = 0b0000;
    
    uint8_t inst = M[PC];
    uint8_t opcode = (inst >> 6) & 0x3;
    uint8_t rd = (inst >> 4) &0x3;
    uint8_t rs1 = (inst >> 2) &0x3;
    uint8_t rs2 = inst & 0x3;
    uint8_t imm = inst & 0xf;
     addr = (inst >> 2) & 0xf;
    if(opcode == 0b00){
        R[rd] = R[rs1] +R[rs2];
        jump_pc = 0;
    }
    else if(opcode == 0b10){
        R[rd] = imm;
        jump_pc = 0;
    }
    else if(opcode == 0b11){
        if(R[rs2] == R[0]){
            jump_pc = 0;
        }
        else if(R[rs2] != R[0]){
            jump_pc = 1;
        }
    }
    else if(opcode == 0b01){
        fprintf(stderr,
            "Unsupported instruction: PC=%u, inst=0x%02x\n",
            (unsigned)PC, (unsigned)inst);
    exit(EXIT_FAILURE);
}
    
    if(jump_pc){
        PC = addr;
    }
    else {
        PC = PC+1;

    }
}
uint8_t *ref_get_regs(){
    return R;
}
