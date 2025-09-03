module lab1_top_tb();
    logic clk, reset;
    logic [3:0] s;
    logic [6:0] seg, seg_expected;
    logic [2:0] led, led_expected;
    logic [15:0] errors, vectornum;
    logic [14:0] testvectors [16:0];
    //                       s[3:0] _ seg[6:0] _ led[2:0]
    
    initial begin
        testvectors[0]  = 14'b0000_0111111_100;
        testvectors[1]  = 14'b0001_0000110_101;
        testvectors[2]  = 14'b0010_1011011_101;
        testvectors[3]  = 14'b0011_1111001_100;
        testvectors[4]  = 14'b0100_1100110_100;
        testvectors[5]  = 14'b0101_1101101_101;
        testvectors[6]  = 14'b0110_1111101_101;
        testvectors[7]  = 14'b0111_0000111_100;
        testvectors[8]  = 14'b1000_1111111_100;
        testvectors[9]  = 14'b1001_1100111_101;
        testvectors[10] = 14'b1010_1110111_101;
        testvectors[11] = 14'b1011_1111100_100;
        testvectors[12] = 14'b1100_0111001_100;
        testvectors[13] = 14'b1101_1011110_101;
        testvectors[14] = 14'b1110_1111001_101;
        testvectors[15] = 14'b1111_1110001_100;
        testvectors[16] = 14'bx;

        reset = 1'b1; #1; reset = 1'b0;
        errors = 16'b0;
        vectornum = 16'b0;
    end

    always begin
        clk = 1'b1; #5; clk = 1'b0; #5;
    end

    lab1_top DUT (.reset(reset), .s(s), .seg(seg), .led(led));

    always @(posedge clk) begin
        {s, seg_expected, led_expected} = testvectors[vectornum];
    end

    always @(negedge clk) begin

        if (testvectors[vectornum] === 14'bx) begin
            $display("%d Tests completed with %d errors!", vectornum, errors);
            $stop;
        end
        $display("s: %h", s);
        if (seg != seg_expected) begin
            $display("ERROR: seg = %b; expected %b", seg, seg_expected);
            errors = errors + 1'b1;
        end else begin
            $display("seg = %b", seg);
        end
        if (led != led_expected) begin
            $display("ERROR: led = %b; expected %b", led, led_expected);
            errors = errors + 1'b1;
        end else begin
            $display("led = %b", led);
        end
    end
endmodule