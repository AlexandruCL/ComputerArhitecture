module d_ff (
    input clk,        // Clock
    input rst_b,      // Active-low reset
    input d,          // Data input
    input set_b,      // Active-low set
    output reg q      // Data output
);
    always @(posedge clk or negedge rst_b or negedge set_b) begin
        if (!rst_b)
            q <= 0;       // Reset output to 0
        else if (!set_b)
            q <= 1;       // Set output to 1
        else
            q <= d;       // Normal operation
    end
endmodule

module lfsr (
    input clk,
    input rst_b,        // Active low reset
    output [8:0] out    // 9-bit output
);
    wire feedback;      // Feedback wire for XOR connections
    reg [8:0] q;        // Outputs of flip-flops

    // XOR feedback logic (Using taps for the LFSR polynomial)
    assign feedback = ((((q[8] ^ q[6]) ^ q[5]) ^ q[3]) ^ q[2]) ^ q[0];

    // D-Flip-Flops for each stage of the LFSR
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b)
            q <= 9'b000000001;  // Force a non-zero initial value
        else
            q <= {q[7:0], feedback}; // Shift left and apply feedback
    end

    // Assign output to the q register values
    assign out = q;

endmodule


module lfsr_tb;
    reg clk, rst_b;
    wire [8:0] q;
    integer count;

    // Instantiate the LFSR module
    lfsr lfsr_i(.clk(clk), .rst_b(rst_b), .out(q));

    // Clock Generation
    localparam CLK_PERIOD = 100;
    initial begin
        clk = 1'b0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    // Reset Logic
    initial begin
        rst_b = 0;       // Active low reset
        #25 rst_b = 1;   // Release reset after 25 time units
    end

    // Monitor the output and check periodicity
    initial begin
        $monitor("Time = %0t, q = %b", $time, q);
        count = 0;

        // Check for periodicity: We will simulate for a number of cycles
        // and detect when the sequence repeats.
        repeat (500) begin
            #CLK_PERIOD;
            count = count + 1;

            // Check if the LFSR is repeating after some cycles
            if (q == 9'b10110011) begin
                $display("LFSR repeated after %0d cycles", count);
                $stop; // Pauses the simulation
            end
        end

        $stop; // End the simulation after a certain number of cycles
    end
endmodule