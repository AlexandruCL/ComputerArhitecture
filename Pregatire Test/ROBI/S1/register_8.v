// 8-bit Register Module
module register_8(
    input clk,
    input [7:0] data,
    input load,
    input reverse,
    input nibble_reverse,
    input rotateleft_b,
    output reg [7:0] q
);
    always @(posedge clk) begin
        if (nibble_reverse) begin
            // Reverse the two nibbles
            q <= {q[3:0], q[7:4]};
        end else if (load) begin
            // Load data into the register
            q <= data;
        end else if (reverse) begin
            // Reverse the entire content
            q <= {q[0], q[1], q[2], q[3], q[4], q[5], q[6], q[7]};
        end else if (!rotateleft_b) begin
            // Rotate left by 1 position
            q <= {q[6:0], q[7]};
        end
    end
endmodule

// Testbench for 8-bit Register
module register_8_tb;
    reg clk;
    reg [7:0] data;
    reg load, reverse, nibble_reverse, rotateleft_b;
    wire [7:0] q;

    register_8 uut (
        .clk(clk),
        .data(data),
        .load(load),
        .reverse(reverse),
        .nibble_reverse(nibble_reverse),
        .rotateleft_b(rotateleft_b),
        .q(q)
    );

    initial begin
        // Initialize signals
        clk = 0;
        data = 8'b00000000;
        load = 0;
        reverse = 0;
        nibble_reverse = 0;
        rotateleft_b = 1;

        // Test Load
        #5 data = 8'b10101010; load = 1;
        #10 load = 0;

        // Test Reverse
        #10 reverse = 1;
        #10 reverse = 0;

        // Test Nibble Reverse
        #10 nibble_reverse = 1;
        #10 nibble_reverse = 0;

        // Test Rotate Left
        #10 rotateleft_b = 0;
        #10 rotateleft_b = 1;

        $finish;
    end

    always #5 clk = ~clk; // Generate clock signal
endmodule