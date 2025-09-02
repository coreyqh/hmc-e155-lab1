module seven_seg_dec_tb();
    logic clk;
    logic [3:0] s;
    logic [6:0] seg;
    logic [15:0] a, b, c, d, e, f, g;

    logic [3:0] errors;

    // Instantiate DUT (active low enabled)
    seven_deg_dec #(1'b1) dut (.s(s), .seg(seg));

    initial begin
        vectornum = 32'b0;
        errors    = 32'b0;
        s         = 4'b0;
        a         = 16'b0100100000010100;
        b         = 16'b0001011000011011;
        c         = 16'b0011000000001011;
        d         = 16'b0100100101100001;
        e         = 16'b0100110101000000;
        f         = 16'b0110000100000100;
        g         = 16'b1100000100001000;
    end

    always begin
        clk = 1; #5; clk = 0; #5;
    end

    always @(posedge clk) begin
        a = a << 1;
        b = b << 1; 
        c = c << 1;
        d = d << 1;
        e = e << 1;
        f = f << 1;
        g = g << 1;
        s = s  + 4'b1;
    end

    always @(negedge clk) begin
        $display("Input: %h", s);
        $display("Segment output: %b", seg);
        if (seg != {g[15], f[15], e[15], d[15], c[15], b[15], a[15]}) begin
            $display("ERROR!: expected segment illumination: %b", {g[15], f[15], e[15], d[15], c[15], b[15], a[15]});
            errors = errors + 1;
        end
        if (s = 4'b1111) begin
            assert (errors == 4'b0) 
                $display("Simulation succeeded!");
            else 
                $display("Simulation Failed with %d errors", errors);
            $stop;
        end
    end

endmodule