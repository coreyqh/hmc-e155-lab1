module top (
    input  logic       reset,
    input  logic [3:0] s,
    output logic [6:0] seg,
    output logic [2:0] led
);
    logic        clk;
    logic [31:0] count;
    logic [31:0] P = 32'd215;

    seven_segment_dec #(.ACTIVE_LOW(1'b1)) dec (.s(s), .seg(seg));

    HSOSC (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));

    // clock divider
    // f = (F * P) / 2^n
    // 2.4 Hz = (4.8*10^6 Hz * 215) / 2^32
    always @(posedge clk) begin
        if (reset) count = 0;
        else begin
            count = count + P;
        end
    end

    assign led[0] = s[1] ^ s[0];
    assign led[1] = s[2] & s[3];
    assign led[2] = count[31];

endmodule