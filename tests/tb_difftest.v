`timescale 1ns/1ps
module tb_difftest;
    reg clk = 0;
    reg rst = 1;
    wire [7:0] pc, r0, r1, r2, r3;
    wire [6:0] low_seg, high_seg;
    wire invalid;
    reg [39:0] expected [0:39];
    integer i;
    top dut(.clk(clk), .rst(rst), .seg1(low_seg), .seg2(high_seg),
        .debug_pc(pc), .debug_r0(r0), .debug_r1(r1),
        .debug_r2(r2), .debug_r3(r3), .debug_invalid(invalid));
    always #5 clk = ~clk;
    initial begin
        $readmemh("expected.hex", expected);
        @(posedge clk); #1;
        if ({pc,r0,r1,r2,r3} !== 40'd0) $fatal(1,"Reset mismatch");
        @(negedge clk); rst = 0;
        for (i=0;i<40;i=i+1) begin
            if (invalid) $fatal(1,"Unsupported instruction at PC %0d",pc);
            @(posedge clk); #1;
            if ({pc,r0,r1,r2,r3} !== expected[i])
                $fatal(1,"Step %0d: RTL=%h REF=%h",i+1,{pc,r0,r1,r2,r3},expected[i]);
            @(negedge clk);
        end
        if (low_seg !== 7'b1111000 || high_seg !== 7'b0110000)
            $fatal(1,"Display mismatch");
        force dut.inst = 8'h40;
        #1; if (!invalid) $fatal(1,"Unsupported opcode not flagged");
        release dut.inst;
        $display("PASS: 40 instruction states match sEMU; display is 37");
        $finish;
    end
endmodule

