module scpu_rom(input wire [7:0] addr, output reg [7:0] inst);
    always @(*) begin
        case (addr)
            8'd0: inst = 8'h8a;
            8'd1: inst = 8'h90;
            8'd2: inst = 8'ha0;
            8'd3: inst = 8'hb1;
            8'd4: inst = 8'h17;
            8'd5: inst = 8'h29;
            8'd6: inst = 8'hd1;
            8'd7: inst = 8'hdf;
            // Match the zero-initialized M[] in sEMU outside the program.
            default: inst = 8'h00;
        endcase
    end
endmodule
