module seven_seg_dec #(parameter ACTIVE_LOW = 1'b1) (
    input  logic [3:0] s,
    output logic [6:0] seg
);
    logic [6:0] seg_int;
    typedef enum logic [6:0] {
        zero  = 7'b0111111;
        one   = 7'b0000110;
        two   = 7'b1011011;
        three = 7'b1111001;
        four  = 7'b1100110;
        five  = 7'b1101101;
        six   = 7'b1111101;
        seven = 7'b0000111;
        eight = 7'b1111111;
        nine  = 7'b1100111;
        A     = 7'b1110111;
        B     = 7'b1111100;
        C     = 7'b0111001;
        D     = 7'b1011110;
        E     = 7'b1111001;
        F     = 7'b1110001;
    } segment_t;

    always_comb
        case (s)
            4'h0:    seg_int = zero;
            4'h1:    seg_int = one;
            4'h2:    seg_int = two;
            4'h3:    seg_int = three;
            4'h4:    seg_int = four;
            4'h5:    seg_int = five;
            4'h6:    seg_int = six;
            4'h7:    seg_int = seven;
            4'h8:    seg_int = eight;
            4'h9:    seg_int = nine;
            4'ha:    seg_int = A;
            4'hb:    seg_int = B;
            4'hc:    seg_int = C;
            4'hd:    seg_int = D;
            4'he:    seg_int = E;
            4'hf:    seg_int = F;
            default: seg_int = 7'bx; // shouldn't happen
        endcase
    
    // if ACTIVE_LOW param is set, zeros turn on the segments, so invert the bits
    if (ACTIVE_LOW) 
        assign seg = ~seg_int;
    else
        assign seg = seg_int; 

endmodule