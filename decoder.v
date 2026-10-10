module decoder(
    input wire [7:0] inst,
    output wire [1:0] opcode, rd, rs1, rs2,
    output wire [3:0] imm, addr,
    output wire is_add, is_li, is_bner0
);
    assign opcode = inst[7:6];
    assign rd = inst[5:4];
    assign rs1 = inst[3:2];
    assign rs2 = inst[1:0];
    assign imm = inst[3:0];
    assign addr = inst[5:2];
    assign is_add = opcode == 2'b00;
    assign is_li = opcode == 2'b10;
    assign is_bner0 = opcode == 2'b11;
endmodule
