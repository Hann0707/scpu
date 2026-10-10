module scpu_regfile(
    input clk,
    input rst,
    input [1:0]raddr1,
    input [1:0]raddr2,
    output [7:0]rdata1,
    output [7:0]rdata2,
    input [1:0]waddr,
    input [7:0]wdata,
    input wen,
    output [7:0] rs0data,
    output [7:0] rs1data,
    output [7:0] rs2data,
    output [7:0] rs3data,
    output [7:0] rddata
);
    reg [7:0] regs [0:3];
    assign rdata1 =  regs[raddr1];
    assign rdata2 = regs[raddr2];
    integer i;
always@(posedge clk)begin
  if (rst) begin
            for (i = 0; i < 4; i = i + 1)
                regs[i] <= 8'd0;
        end
  else if(wen)begin
    regs[waddr] <= wdata;
  end
    
end
assign rs0data = regs[0];
assign rs1data = regs[1];
assign rs2data = regs[2];
assign rs3data = regs[3];
assign rddata = regs[waddr];
endmodule 