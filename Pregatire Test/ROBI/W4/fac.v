// Construct a Verilog module for a Full Adder Cell (FAC), and name
// it fac. The module has 3 1-bit inputs x, y and ci, and 2 1-bit
// outputs z and co. Write your code in a file called fac.v.

module fac(input x, y, ci, output z, co);

    assign z = x ^ y ^ ci;
    assign co = x & y | x & ci | y & ci;
endmodule

module fac_tb;

    reg x, y, ci;
    wire z, co;

    fac i0(.x(x), .y(y), .ci(ci), .z(z), .co(co));

    integer i;
    initial begin
        
        $monitor("%4t\t%b\t%b\t%b\t||\t%b\t%b", $time, x, y, ci, z, co);
        for(i = 0; i < 8; i = i + 1) begin
            {x, y, ci} = i;
            #10;
    end
    end
endmodule