#define main semu_original_main
#include "semu_ref.c"
#undef main
int main(void) {
    uint8_t program[] = {0x8a,0x90,0xa0,0xb1,0x17,0x29,0xd1,0xdf};
    for (int i=0;i<8;i++) M[i]=program[i];
    for (int i=0;i<40;i++) {
        inst_cycle();
        printf("%02x%02x%02x%02x%02x\n", PC,R[0],R[1],R[2],R[3]);
    }
    return !(PC==7 && R[0]==10 && R[1]==10 && R[2]==55 && R[3]==1);
}
