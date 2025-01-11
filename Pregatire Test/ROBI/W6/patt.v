module patt(
    input clk,            // Clock signal
    input rst_b,          // Asynchronous reset, active low
    input start,          // Start signal for the operation
    input [3:0] x, y,     // 4-bit inputs X and Y
    output reg [3:0] z,   // 4-bit output Z (result)
    output reg done       // Done signal (high when addition completes)
);

    // State definitions
    localparam S0 = 0;    // Initial state (no carry)
    localparam S1 = 1;    // Carry state

    reg st, st_nxt;       // Current and next states
    reg [3:0] x_reg, y_reg; // Shift registers for X and Y
    reg [3:0] z_reg;      // Shift register for result Z
    reg carry;            // Carry bit
    reg [2:0] bit_count;  // Bit counter to track 4 bits

    always @(*) begin
        // Default next state
        st_nxt = st;
        case (st)
            S0: if (carry) st_nxt = S1;  // Transition to carry state
            S1: if (!carry) st_nxt = S0; // Transition to no-carry state
        endcase
    end

    always @(*) begin
        // Default outputs
        done = 0;
        z = 0;

        case (st)
            S0: z = z_reg; // Output the current result in no-carry state
            S1: z = z_reg; // Output the current result in carry state
        endcase
    end

    // Sequential logic for FSM, registers, and carry
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            st <= S0;
            x_reg <= 0;
            y_reg <= 0;
            z_reg <= 0;
            carry <= 0;
            bit_count <= 0;
            done <= 0;
        end else if (start) begin
            if (bit_count < 4) begin
                // Perform bit-by-bit addition
                {carry, z_reg[bit_count]} = x_reg[bit_count] + y_reg[bit_count] + carry;
                bit_count <= bit_count + 1;
            end else begin
                // Finish addition
                done <= 1;
            end
        end
    end

    // Load inputs into shift registers on start signal
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            x_reg <= 0;
            y_reg <= 0;
        end else if (start) begin
            x_reg <= x;
            y_reg <= y;
        end
    end

endmodule

module patt_tb;

    reg clk, rst_b, start;
    reg [3:0] x, y;
    wire [3:0] z;
    wire done;

    patt uut (
        .clk(clk),
        .rst_b(rst_b),
        .start(start),
        .x(x),
        .y(y),
        .z(z),
        .done(done)
    );

    localparam CLK_PERIOD = 100;

    // Clock generation
    initial clk = 0;
    always #(CLK_PERIOD / 2) clk = ~clk;

    initial begin
        // Initialize signals
        rst_b = 0;
        start = 0;
        x = 0;
        y = 0;

        // Reset
        #(CLK_PERIOD / 4) rst_b = 1;

        // Test case: Add 0110 (6) and 0011 (3)
        x = 4'b0110;
        y = 4'b0011;
        start = 1;

        // Wait for operation to complete
        #500;
        start = 0;

        // Observe the result
        $display("X = %b, Y = %b, Z = %b, Done = %b", x, y, z, done);

        // End simulation
        #200 $stop;
    end

endmodule
