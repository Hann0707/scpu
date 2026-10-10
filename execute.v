module execute(
    input [7:0]rdata1,
    input [7:0]rdata2,
    input is_add,
    input is_li,
    input is_bner0,
    input is_io,
    input io,
    input rst,
    input [7:0]rs0data,
    input [1:0]rd,
    input[3:0] imm,
    input[3:0] addr,
    input clk,
    input [7:0] rddata,
    output reg [3:0] seg7_1,
    output reg [3:0] seg7_2,
    output reg wpcaddr,
    output reg [7:0] wdata,
    output reg [3:0]romaddr,//pc跳转的地址
    output reg [1:0] waddr,
    output reg wen

    
);
    always@(*)begin
        waddr   = rd;
    wdata   = 8'd0;
    wpcaddr = 1'b0;
    romaddr = addr;
    
    wen = 0;
      if(is_add)begin
        waddr = rd;
        wdata = rdata1+rdata2;
        wen = 1'b1;
      end
      if(is_li)begin
        waddr = rd;
        wdata = {4'b0000,imm};
        wen = 1'b1;
      end
      if(is_bner0)begin
        wpcaddr = (rs0data==rdata2)?0:1;
        romaddr =  addr;
      end
      
    end
    always @(posedge clk) begin
    if (rst) begin
        seg7_1 <= 4'd0;
        seg7_2 <= 4'd0;
    end
    else if (is_io && io) begin
        seg7_1 <= rddata[3:0];
        seg7_2 <= rddata[7:4];
    end
end
endmodule