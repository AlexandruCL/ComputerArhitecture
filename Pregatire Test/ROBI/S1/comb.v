module comb(input [4:0] i, output reg m, n);

    always @(*) begin
        m = 1'b1;
        n = 1'b1;
        case(i)
            5'b00001: begin m = 1'b0; n = 1'b1; end
            5'b0001?: begin m = 1'b1; n = 1'b0; end
            5'b001??: begin m = 1'b0; n = 1'b1; end
            5'b01000: begin m = 1'b1; n = 1'b1; end
            5'b01001: begin m = 1'b1; n = 1'b0; end
            5'b0101?: begin m = 1'b0; n = 1'b1; end
            5'b011??: begin m = 1'b1; n = 1'b1; end
            5'b10???: begin m = 1'b0; n = 1'b1; end
            5'b11000: begin m = 1'b0; n = 1'b0; end
            5'b11001: begin m = 1'b1; n = 1'b1; end
            5'b1101?: begin m = 1'b0; n = 1'b1; end 
            5'b11100: begin m = 1'b1; n = 1'b0; end
            5'b11101: begin m = 1'b1; n = 1'b1; end
            5'b11110: begin m = 1'b1; n = 1'b0; end
            5'b11111: begin m = 1'b0; n = 1'b1; end
        endcase
    end
endmodule

module comb_tb;

    reg [4:0] i;            // Test input (5 bits wide)
    wire m, n;              // Observed outputs

    // Instantiate the DUT (Device Under Test)
    comb dut(.i(i), .m(m), .n(n));

    integer k;

    initial begin
        $display("Time\ti     \tm n");
        $monitor("%0t\t%b\t%b %b", $time, i, m, n);

        // Iterate through all input combinations
        for (k = 0; k < 32; k = k + 1) begin
            i = k;   // Assign test input
            #10;     // Wait 10 time units
        end

        $finish; // End simulation
    end
endmodule

