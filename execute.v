module execute(
    input wire [7:0] rdata1, rdata2, rs0data,
    input wire is_add, is_li, is_bner0,
    input wire [1:0] rd,
    input wire [3:0] imm, addr,
    output wire wpcaddr,
    output wire [7:0] wdata,
    output wire [3:0] romaddr,
    output wire [1:0] waddr,
    output wire wen
);
    assign waddr = rd;
    assign wdata = is_li ? {4'b0000, imm} : rdata1 + rdata2;
    assign wen = is_add | is_li;
    assign wpcaddr = is_bner0 && (rs0data != rdata2);
    assign romaddr = addr;
endmodule
