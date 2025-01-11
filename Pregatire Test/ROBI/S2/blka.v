// blkasm.v

module blkasm (
    input [32:0] data,       // 33-bit input: 4-bit position + 29-bit packet
    input avl,              // 1-bit input: available flag
    input clk,              // Clock signal
    input reset,            // Reset signal
    output [463:0] blk      // 464-bit block output
);

    // Internal wires and registers
    wire [3:0] position;         // Extract position from input data
    wire [28:0] packet;          // Extract packet from input data
    wire [15:0] received_mask;   // 16-bit mask to track received packets
    reg [463:0] blk_reg;         // Register to store block
    reg [15:0] received;         // Register to track received packets
    wire all_received;           // Signal to indicate all packets received

    assign position = data[32:29];  // Extract position
    assign packet = data[28:0];     // Extract packet

    // Decoder module for generating a mask for the received packet position
    dec #(.WIDTH(16)) decoder (
        .input_data(position),
        .output_mask(received_mask)
    );

    // Register module to store the received packets in the block
    rgst #(.WIDTH(464)) block_register (
        .clk(clk),
        .reset(reset),
        .enable(avl),
        .data_in(blk_reg),
        .data_out(blk)
    );

    // Counter module to track received packets
    cntr #(.WIDTH(16)) packet_counter (
        .clk(clk),
        .reset(reset),
        .increment(avl & ~received[position]),
        .count(received)
    );

    // Continuous assignment to update blk_reg when a new packet is received
    always @(*) begin
        blk_reg = blk;
        if (avl && ~received[position]) begin
            blk_reg[position * 29 +: 29] = packet; // Insert packet into correct position
        end
    end

    // Determine if all packets are received
    assign all_received = (received == 16'hFFFF);

    // Output high-impedance state until all packets are received
    assign blk = all_received ? blk_reg : 464'bz;

endmodule

// Decoder module
module dec #(parameter WIDTH = 16) (
    input [3:0] input_data,
    output reg [WIDTH-1:0] output_mask
);
    always @(*) begin
        output_mask = 0;
        output_mask[input_data] = 1'b1;
    end
endmodule

// Register module
module rgst #(parameter WIDTH = 464) (
    input clk,
    input reset,
    input enable,
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 0;
        end else if (enable) begin
            data_out <= data_in;
        end
    end
endmodule

// Counter module
module cntr #(parameter WIDTH = 16) (
    input clk,
    input reset,
    input increment,
    output reg [WIDTH-1:0] count
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
        end else if (increment) begin
            count <= count + 1;
        end
    end
endmodule
