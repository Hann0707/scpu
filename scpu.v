module top(
    input wire clk, rst,
    output wire [6:0] seg1, seg2,
    output wire [7:0] debug_pc,
    output wire [7:0] debug_r0, debug_r1, debug_r2, debug_r3,
    output wire debug_invalid
);
    wire [7:0] inst, rdata1, rdata2, wdata;
    wire [1:0] opcode, rd, rs1, rs2, waddr;
    wire [3:0] addr, jump_addr, imm;
    wire is_add, is_li, is_bner0, wpcaddr, wen;

    pc u_pc(.clk(clk), .rst(rst), .wpcaddr(wpcaddr),
            .addr(jump_addr), .romaddr(debug_pc));
    scpu_rom u_scpu_rom(.addr(debug_pc), .inst(inst));
    decoder u_decoder(.inst(inst), .opcode(opcode), .rd(rd),
        .rs1(rs1), .rs2(rs2), .imm(imm), .addr(addr),
        .is_add(is_add), .is_li(is_li), .is_bner0(is_bner0));
    scpu_regfile u_scpu_regfile(.clk(clk), .rst(rst),
        .raddr1(rs1), .raddr2(rs2), .rdata1(rdata1), .rdata2(rdata2),
        .waddr(waddr), .wdata(wdata), .wen(wen),
        .rs0data(debug_r0), .rs1data(debug_r1),
        .rs2data(debug_r2), .rs3data(debug_r3), .rddata());
    execute u_execute(.rdata1(rdata1), .rdata2(rdata2),
        .rs0data(debug_r0), .is_add(is_add), .is_li(is_li),
        .is_bner0(is_bner0), .rd(rd), .imm(imm), .addr(addr),
        .wpcaddr(wpcaddr), .romaddr(jump_addr),
        .waddr(waddr), .wdata(wdata), .wen(wen));

    // Display R[2] directly; no architectural I/O instruction is needed.
    seg7_decoder u_seg_low(.hex_data(debug_r2[3:0]), .dp_in(1'b0), .seg(seg1));
    seg7_decoder u_seg_high(.hex_data(debug_r2[7:4]), .dp_in(1'b0), .seg(seg2));
    assign debug_invalid = opcode == 2'b01;
endmodule
