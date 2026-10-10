module seg7_decoder (
    input  wire [3:0] hex_data,  // 4位输入数据 (0x0 ~ 0xF)
    input  wire       dp_in,     // 小数点输入: 1为点亮, 0为熄灭
    output reg  [6:0] seg        // 数码管输出段选 [dp, g, f, e, d, c, b, a]，低电平有效
);

    // 段定义：
    // bit 0: a
    // bit 1: b
    // bit 2: c
    // bit 3: d
    // bit 4: e
    // bit 5: f
    // bit 6: g
    // bit 7: dp (小数点)

    always @(*) begin
        case (hex_data)
            4'h0: seg[6:0] = 7'b100_0000; // 0: 仅 g 熄灭
            4'h1: seg[6:0] = 7'b111_1001; // 1: 仅 b, c 点亮
            4'h2: seg[6:0] = 7'b010_0100; // 2: 仅 c, f 熄灭
            4'h3: seg[6:0] = 7'b011_0000; // 3: 仅 e, f 熄灭
            4'h4: seg[6:0] = 7'b001_1001; // 4: 仅 a, d, e 熄灭
            4'h5: seg[6:0] = 7'b001_0010; // 5: 仅 b, e 熄灭
            4'h6: seg[6:0] = 7'b000_0010; // 6: 仅 b 熄灭
            4'h7: seg[6:0] = 7'b111_1000; // 7: 仅 a, b, c 点亮
            4'h8: seg[6:0] = 7'b000_0000; // 8: 全亮
            4'h9: seg[6:0] = 7'b001_0000; // 9: 仅 e 熄灭
            4'hA: seg[6:0] = 7'b000_1000; // A: 仅 d 熄灭
            4'hb: seg[6:0] = 7'b000_0011; // b: 仅 a, b 熄灭
            4'hC: seg[6:0] = 7'b100_0110; // C: 仅 b, c, g 熄灭
            4'hd: seg[6:0] = 7'b010_0001; // d: 仅 a, f 熄灭
            4'hE: seg[6:0] = 7'b000_0110; // E: 仅 b, c 熄灭
            4'hF: seg[6:0] = 7'b000_1110; // F: 仅 b, c, d 熄灭
            default: seg[6:0] = 7'b111_1111; // 全灭
        endcase

        // 小数点也是低电平有效：输入1点亮对应输出0
        
    end

endmodule