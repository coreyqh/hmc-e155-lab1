module led_blinker_2hz (
    output logic led
);

    // Internal oscillator output
    logic clk;
    logic clk_en;

    // Instantiate the high-frequency oscillator (typically 48 MHz)
    HSOSC #(
        .CLKHF_DIV("0b00")  // No division: 48 MHz
    ) hf_osc_inst (
        .CLKHFEN(clk_en),
        .CLKHFPU(clk_en),
        .CLKHF(clk)
    );

    // Enable the oscillator
    initial clk_en = 1'b1;

    // Counter to divide 48 MHz down to 2 Hz
    // 48,000,000 / 2 = 24,000,000 clock cycles per toggle
    localparam int COUNT_MAX = 24_000_000;
    logic [$clog2(COUNT_MAX)-1:0] counter = 0;

    always_ff @(posedge clk) begin
        if (counter == COUNT_MAX - 1) begin
            counter <= 0;
            led <= ~led;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule
