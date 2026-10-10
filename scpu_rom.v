module scpu_rom (
    input [7:0]addr,
    output reg [7:0] inst
);
always@(*)begin
    case(addr)
            4'd0: inst = 8'h8a; // li r0, 10
            4'd1: inst = 8'h90; // li r1, 0
            4'd2: inst = 8'ha0; // li r2, 0
            4'd3: inst = 8'hb1; // li r3, 1
            4'd4: inst = 8'h17; // add r1, r1, r3
            4'd5: inst = 8'h29; // add r2, r2, r1
            4'd6: inst = 8'b01101001;
            4'd7: inst = 8'hd1; // bner0 r1, 4
            4'd8: inst = 8'he3; // bner0 r3, 8
            default: inst = 8'h40; 
    endcase
end
    
endmodule