module adder(
    input [4:0] x, y,
    output [4:0] z
);

    // first A module
    wire g_A0, p_A0;
    A a0(.x(x[0]), .y(y[0]), .e(z[0]), .g(g_A0), .p(p_A0));

    // second A module
    wire e_A1, g_A1, p_A1;
    A a1(.x(x[1]), .y(y[1]), .e(e_A1), .g(g_A1), .p(p_A1));
    
    assign z[1] = e_A1 ^ g_A0;

    wire g_B0, p_B0;
    B b0(.g2(g_A1), .p2(p_A1), .g1(g_A0), .p1(p_A0), .g(g_B0), .p(p_B0));

    // third A module
    wire e_A2, g_A2, p_A2;
    A a2(.x(x[2]), .y(y[2]), .e(e_A2), .g(g_A2), .p(p_A2));

    assign z[2] = e_A2 ^ g_B0;

    B b1(.g2(g_A2), .p2(p_A2), .g1(g_B0), .p1(p_B0), .g(g_B1), .p(p_B1));

    // fourth A module
    wire e_A3, g_A3, p_A3;
    A a3(.x(x[3]), .y(y[3]), .e(e_A3) ,.g(g_A3), .p(p_A3));

    assign z[3] = e_A3 ^ g_B1;

    wire g_B2, p_B2;
    B b2(.g2(g_A3), .p2(p_A3), .g1(g_A2), .p1(p_A2), .g(g_B2), .p(p_B2));

    wire g_B3, p_B3;
    B b3(.g2(g_B2), .p2(p_B2), .g1(g_B0), .p1(p_B0), .g(g_B3), .p(p_B3));

    //fifth A module
    wire e_A4, g_A4, p_A4;
    A a4(.x(x[4]), .y(y[4]), .e(e_A4), .g(g_A4), .p(p_A4));

    assign z[4] = e_A4 ^ g_B3;
endmodule

`timescale 1ns/1ps
module adder_tb;

    // Testbench signals
    reg [4:0] x, y;        // Inputs to the adder
    wire [4:0] z;          // Output from the adder

    // Instantiate the DUT (Device Under Test)
    adder dut (
        .x(x),
        .y(y),
        .z(z)
    );

    // Task to display results
    task display_results;
        input [4:0] x_input, y_input, z_output;
        begin
            $display("Time=%0t | x=%b | y=%b | z=%b", $time, x_input, y_input, z_output);
        end
    endtask

    // Stimulus generation
    initial begin
        $monitor("Time=%0t | x=%b | y=%b | z=%b", $time, x, y, z);

        // Test cases
        x = 5'b00000; y = 5'b00000; #10; display_results(x, y, z);
        x = 5'b00001; y = 5'b00001; #10; display_results(x, y, z);
        x = 5'b00101; y = 5'b00011; #10; display_results(x, y, z);
        x = 5'b10101; y = 5'b01011; #10; display_results(x, y, z);
        x = 5'b11111; y = 5'b11111; #10; display_results(x, y, z);
        x = 5'b01100; y = 5'b00101; #10; display_results(x, y, z);
        x = 5'b11100; y = 5'b01010; #10; display_results(x, y, z);

        // End simulation
        $stop;
    end

endmodule
