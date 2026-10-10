module top(
    input clk,
    input rst,
    output [6:0]seg1,
    output [6:0]seg2
);

wire[3:0] addr;
wire[7:0] romaddr;
wire[7:0] inst;
wire [1:0] rd;
wire [1:0] rs1;
wire [1:0] rs2;
wire io;
wire[3:0] imm;
wire[2:0] idx;
wire is_add;
wire is_io;
wire is_li;
wire is_bner0;
wire[7:0] rdata1;
wire [7:0] rdata2;
wire [1:0] waddr;
wire [7:0] wdata;
wire wen;
wire [7:0] rs0data;
    wire  [7:0] rs1data;
    wire [7:0] rs2data;
    wire [7:0] rs3data;
    wire [7:0] rddata;
wire [3:0] seg7_1;
    wire [3:0] seg7_2;
    wire wpcaddr;
    // 顶层新增
wire [3:0] jump_addr;

pc u_pc(
    .clk(clk),
    .rst(rst),
    .wpcaddr(wpcaddr),
    .addr(jump_addr),
    .romaddr(romaddr)
);
scpu_rom u_scpu_rom(
    .addr(romaddr),
    .inst(inst)
);
decoder u_decoder(
    .inst(inst),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2),
    .io(io),
    .imm(imm),
    .addr(addr),
    .idx(idx),
    .is_add(is_add),
    .is_io(is_io),
    .is_li(is_li),
    .is_bner0(is_bner0)

);
scpu_regfile u_scpu_regfile(
   .clk(clk),
   .rst(rst),
    .raddr1(rs1),
    .raddr2(rs2),
    .rdata1(rdata1),
    .rdata2(rdata2),
    
    .waddr(waddr),
    .wdata(wdata),
    .wen(wen),
    .rs0data(rs0data),
    .rs1data(rs1data),
    .rs2data(rs2data),
    .rs3data(rs3data),
    .rddata(rddata)
);
execute u_execute(
    .rdata1(rdata1),
    .rdata2(rdata2),
    .is_add(is_add),
    .is_io(is_io),
    .is_li(is_li),
    .is_bner0(is_bner0),
    .io(io),
    .rst(rst),
    .rs0data(rs0data),
    .rd(rd),
    .imm(imm),
    .addr(addr),
    .clk(clk),
    .rddata(rddata),
    .seg7_1(seg7_1),
    .seg7_2(seg7_2),
    .wpcaddr(wpcaddr),
    .wdata(wdata),
    .romaddr(jump_addr),
    .waddr(waddr),
    .wen(wen)


);
seg7_decoder u1_seg7_decoder(
    .hex_data(seg7_1),
    .seg(seg1)
);
seg7_decoder u2_seg7_decoder(
    .hex_data(seg7_2),
    .seg(seg2)
);
endmodule
