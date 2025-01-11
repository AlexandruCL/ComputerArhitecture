// Half Adder Module
module hac(input x, input y, output z, output co);
    assign z = x ^ y;   // XOR for sum
    assign co = x & y;  // AND for carry out
endmodule

// Full Adder Module
module fac(input x, input y, input ci, output z, output co);
    assign z = x ^ y ^ ci;            // XOR for sum
    assign cout = (x & y) | (x & ci) | (y & ci);  // Majority function for carry out
endmodule

// Multiplier Module
module mult(input [3:0] x, input [3:0] y, output [7:0] p);
    wire [3:0] pp[3:0]; // Partial products
    wire [6:0] c;       // Carry signals
    wire [6:0] s;       // Sum signals

    // Generate Partial Products
    genvar i, j;
    generate
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                assign pp[i][j] = x[i] & y[j];
            end
        end
    endgenerate

    // First Row: Directly assign partial products
    assign p[0] = pp[0][0];

    // Second Row: Use HAC and FAC for addition
    hac ha1 (.a(pp[1][0]), .b(pp[0][1]), .sum(p[1]), .cout(c[0]));
    fac fa1 (.a(pp[2][0]), .b(pp[1][1]), .cin(pp[0][2]), .sum(s[0]), .cout(c[1]));
    fac fa2 (.a(pp[3][0]), .b(pp[2][1]), .cin(pp[1][2]), .sum(s[1]), .cout(c[2]));

    // Third Row
    fac fa3 (.a(pp[3][1]), .b(pp[2][2]), .cin(pp[1][3]), .sum(s[2]), .cout(c[3]));
    fac fa4 (.a(c[0]), .b(s[0]), .cin(pp[0][3]), .sum(p[2]), .cout(c[4]));
    fac fa5 (.a(c[1]), .b(s[1]), .cin(c[4]), .sum(p[3]), .cout(c[5]));

    // Fourth Row
    fac fa6 (.a(c[2]), .b(s[2]), .cin(c[5]), .sum(p[4]), .cout(c[6]));
    fac fa7 (.a(c[3]), .b(pp[3][2]), .cin(c[6]), .sum(p[5]), .cout(p[6]));

    // Final output
    assign p[7] = pp[3][3];
endmodule

// Testbench
module mult_tb;
    reg [3:0] x, y;
    wire [7:0] p;

    mult uut (.x(x), .y(y), .p(p));

    integer i, j;

    initial begin
        $display("Time\tx\ty\tp");
        $monitor("%0t\t%b\t%b\t%b", $time, x, y, p);

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                x = i; y = j;
                #10;
            end
        end

        $finish;
    end
endmodule
