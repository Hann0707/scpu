#include<stdio.h>
#include<stdint.h>
#include <stdlib.h>
uint8_t PC = 0;
uint8_t R[4];
uint8_t M[256];
int jump_pc = 0;

void inst_cycle (){
    
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
int main(){
    M[0] = 0b10001010;
    M[1] = 0b10010000;
    M[2] = 0b10100000;
    M[3] = 0b10110001;
    M[4] = 0b00010111;
    M[5] = 0b00101001;
    M[6] = 0b11010001;
    M[7] = 0b11011111;
    while(1){
        inst_cycle();
    }
}