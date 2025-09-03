// lab1_top_tb.sv
// written: Corey Hickson chickson@hmc.edu 9/2/2025
// Purpose: functional testbench of the top level module for e155 lab1

module lab1_top_tb();
    logic clk, reset;
    logic [3:0] s;
    logic [6:0] seg, seg_expected;
    logic [2:0] led, led_expected;
    logic [15:0] errors, vectornum;
    //                                   s[3:0] _ seg[6:0] _ led[2:0]
    logic [14:0] testvectors [0:16] = '{14'b0000_1000000_000,
                                        14'b0001_1111001_001,
                                        14'b0010_0100100_001,
                                        14'b0011_0110000_000,
                                        14'b0100_0011001_000,
                                        14'b0101_0010010_001,
                                        14'b0110_0000010_001,
                                        14'b0111_1111000_000,
                                        14'b1000_0000000_000,
                                        14'b1001_0011000_001,
                                        14'b1010_0001000_001,
                                        14'b1011_0000011_000,
                                        14'b1100_1000110_010,
                                        14'b1101_0100001_011,
                                        14'b1110_0000110_011,
                                        14'b1111_0001110_010,
                                        14'bx };

    initial begin
        errors = 16'b0;
        vectornum = 16'b0;
        reset = 1'b0; #1; reset = 1'b1; #1; reset = 1'b0;
    end

    always begin
        clk = 1'b1; #5; clk = 1'b0; #5;
    end

    lab1_top DUT (.reset(reset), .s(s), .seg(seg), .led(led));

    always @(posedge clk) begin
        if (!reset) {s, seg_expected, led_expected} = testvectors[vectornum];
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
        vectornum = vectornum + 1;
    end
endmodule