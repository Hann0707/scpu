module pc(
    input clk,
    input rst,
    input wpcaddr,
    input [3:0]addr,
    output reg[7:0] romaddr

);

always@(posedge clk)
begin
  if(rst)begin
    romaddr<=8'b00000000;
  end
  else if(wpcaddr)begin
    romaddr<={4'b0000,addr};
  end
  else begin
    romaddr<=romaddr + 8'd1;
  end
end
endmodule