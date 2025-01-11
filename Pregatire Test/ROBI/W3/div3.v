// Construct a module named div3, having an input i, on 4 bits and
// an output o, on the minimum number of bits so that at the output
// to provide the quotient of dividing by 3 the unsigned number
// connected at the input i. Do not use the ”/” Verilog division
// operator for this exercise and implement the module using an
// always block. Example: i = 10 → o = 3; i = 2 → o = 0.

module div3(input [3:0] i, output reg [2:0] o); // 3-bit output
    integer j; // Temporary variable for the division process

    always @(*) begin
        o = 0;       // Initialize the output
        j = i;       // Initialize the temporary variable with input

        // Division by repeated subtraction
        while (j >= 3) begin
            j = j - 3; // Subtract 3 from j
            o = o + 1; // Increment the quotient
        end
    end
endmodule

// Testbench
module div3_tb;

    reg [3:0] i;
    wire [2:0] o;

    div3 div3_i(.i(i), .o(o)); // Instantiate the div3 module

    integer k;
    initial begin
        $display("Time\ti\t\to");
        $monitor("%0t\t%b (%2d)\t%b (%2d)", $time, i, i, o, o); // Display both binary and decimal
        i = 0; // Initialize the input

        // Test all values from 0 to 15
        for (k = 0; k < 16; k = k + 1) begin
            #10 i = k; // Apply next input value
        end
    end
endmodule

