module regfl_4x8 (
    input clk,                  // Clock signal
    input rstb,                 // Asynchronous reset, active low
    input [7:0] wr_data,        // Data to write into the register file
    input [1:0] wr_addr,        // Write address (selects which register to write to)
    input wr_e,                 // Write enable
    output [7:0] rd_data,       // Data read from the register file
    input [1:0] rd_addr         // Read address (selects which register to read from)
);

    // Internal registers (4 x 8-bit)
    reg [7:0] reg_array [0:3];

    // Write logic
    always @(posedge clk or negedge rstb) begin
        if (!rstb) begin
            // Reset all registers to 0
            reg_array[0] <= 8'b0;
            reg_array[1] <= 8'b0;
            reg_array[2] <= 8'b0;
            reg_array[3] <= 8'b0;
        end else if (wr_e) begin
            // Write data to the selected register
            case (wr_addr)
                2'b00: reg_array[0] <= wr_data;
                2'b01: reg_array[1] <= wr_data;
                2'b10: reg_array[2] <= wr_data;
                2'b11: reg_array[3] <= wr_data;
            endcase
        end
    end

    // Read logic (4-to-1 multiplexer)
    assign rd_data = (rd_addr == 2'b00) ? reg_array[0] :
                     (rd_addr == 2'b01) ? reg_array[1] :
                     (rd_addr == 2'b10) ? reg_array[2] :
                     reg_array[3];

endmodule


module regfl_4x8_tb;

    reg clk;
    reg rstb;
    reg [7:0] wr_data;
    reg [1:0] wr_addr;
    reg wr_e;
    reg [1:0] rd_addr;
    wire [7:0] rd_data;

    regfl_4x8 uut (
        .clk(clk),
        .rstb(rstb),
        .wr_data(wr_data),
        .wr_addr(wr_addr),
        .wr_e(wr_e),
        .rd_data(rd_data),
        .rd_addr(rd_addr)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 10ns clock period

    initial begin
        // Initialize inputs
        rstb = 0; wr_data = 0; wr_addr = 0; wr_e = 0; rd_addr = 0;

        // Reset registers
        #10 rstb = 1;

        // Write data to register 0
        #10 wr_data = 8'hAA; wr_addr = 2'b00; wr_e = 1;
        #10 wr_e = 0;

        // Write data to register 1
        #10 wr_data = 8'hBB; wr_addr = 2'b01; wr_e = 1;
        #10 wr_e = 0;

        // Read data from register 0
        #10 rd_addr = 2'b00;

        // Read data from register 1
        #10 rd_addr = 2'b01;

        // Write data to register 2
        #10 wr_data = 8'hCC; wr_addr = 2'b10; wr_e = 1;
        #10 wr_e = 0;

        // Read data from register 2
        #10 rd_addr = 2'b10;

        // End simulation
        #20 $stop;
    end

endmodule
