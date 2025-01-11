// module lsfr(input clk, rst,_b, output [8:0] q);

//     genvar k;
//     generate
//         for(k = 0; k < 5; k = k + 1) begin:arr
//             if (k == 0)
//             else if (k == 2)
//             else if(k == 4)
//             else if(k == 6)
//             else if(k == 8)
//             else 
//     endgenerate
// endmodule

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
    wire [8:0] q;       // Outputs of flip-flops

    // XOR feedback logic (Using taps for the LFSR polynomial)
    assign feedback = ((((q[8] ^ q[6]) ^ q[5]) ^ q[3]) ^ q[2]) ^ q[0];

    // D-Flip-Flops for each stage of the LFSR
    d_ff dff0 (.clk(clk), .rst_b(rst_b), .set_b(1'b1), .d(feedback), .q(q[0])); // Tie set_b to 1'b1
    d_ff dff1 (.clk(clk), .rst_b(rst_b), .set_b(1'b1), .d(q[0]), .q(q[1]));
    d_ff dff2 (.clk(clk), .rst_b(rst_b), .set_b(1'b1), .d(q[1]), .q(q[2]));
    d_ff dff3 (.clk(clk), .rst_b(rst_b), .set_b(1'b1), .d(q[2]), .q(q[3]));
    d_ff dff4 (.clk(clk), .rst_b(rst_b), .set_b(1'b1), .d(q[3]), .q(q[4]));
    d_ff dff5 (.clk(clk), .rst_b(rst_b), .set_b(1'b1), .d(q[4]), .q(q[5]));
    d_ff dff6 (.clk(clk), .rst_b(rst_b), .set_b(1'b1), .d(q[5]), .q(q[6]));
    d_ff dff7 (.clk(clk), .rst_b(rst_b), .set_b(1'b1), .d(q[6]), .q(q[7]));
    d_ff dff8 (.clk(clk), .rst_b(rst_b), .set_b(1'b1), .d(q[7]), .q(q[8]));

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
        repeat (1000) begin
            #CLK_PERIOD;
            count = count + 1;

            if (q == 9'b10110011) begin
                $display("LFSR repeated after %0d cycles", count);
                $stop; // Pauses the simulation
            end
        end

        $stop;
    end
endmodule



// module lfsr_tb;
//     reg clk, rst_b;        // Declaring clock and reset signals
//     wire [8:0] q;          // Wire to hold the output from the LFSR

//     // Instantiate the LFSR module
//     lfsr lfsr_i(
//         .clk(clk), 
//         .rst_b(rst_b),  // Ensure the signal matches the module definition
//         .out(q)
//     );

//     // Parameters for clock and simulation duration
//     localparam CLK_PERIOD = 100; // 10 MHz clock period
//     localparam CLK_CYCLES = 100; // Number of clock cycles to simulate

//     // Generate clock signal
//     initial begin
//         clk = 1'b0;
//         repeat (2*CLK_CYCLES) #(CLK_PERIOD/2) clk = ~clk;  // Toggle clock every half cycle
//     end

//     // Generate reset signal (active-low)
//     localparam RST_DURATION = 25; // Duration of reset
//     initial begin
//         rst_b = 0;  // Assert reset initially
//         #RST_DURATION
//         rst_b = 1;  // Deassert reset after RST_DURATION
//     end

//     // Monitor the output and check periodicity
//     initial begin
//         // Print output q during the simulation to observe its behavior
//         $monitor("Time = %0t, q = %b", $time, q);

//         // Run the simulation for a specified duration based on clock cycles
//         #(CLK_PERIOD * CLK_CYCLES);  // Run for the number of clock cycles
        
//         // End simulation after running for the set clock cycles
//         $stop; 
//     end
// endmodule


