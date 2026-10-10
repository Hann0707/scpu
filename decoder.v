module decoder(
    input [7:0]inst,
    output [1:0]opcode,
    output [1:0] rd,
    output [1:0] rs1,
    output [1:0] rs2,
    output io,
    output [3:0] imm,
    output [3:0] addr,
    output [2:0] idx,
    output is_add,
    output is_io,
    output is_li,
    output is_bner0
);
assign opcode = inst[7:6];
assign rd = inst[5:4];
assign rs1 = inst[3:2];
assign rs2 = inst[1:0];
assign io = inst[3];
assign imm = inst[3:0];
assign addr = inst[5:2];
assign idx = inst[2:0];
assign is_add   = (opcode == 2'b00);
assign is_io = (opcode==2'b01);
    assign is_li    = (opcode == 2'b10);
    assign is_bner0 = (opcode == 2'b11);

endmodule