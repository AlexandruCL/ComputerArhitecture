// Using 2 fac instances, construct a 2-bit adder called add2b, having
// 2, 2-bit inputs x and y and the 1-bit input ci, together with the
// 2-bit output o and the 1-bit output co. Write your code in file
// add2b.v.
// Construct a testbench module for verifying your implementation,
// called add2b tb and the associated script file run add2b.txt

module add2b(input [1:0] x, y, input ci, output [1:0] z, output co);

    fac i0(.x(x[0]), .y(y[0]), .ci(ci), .z(z[0]), .co(c1));
    fac i1(.x(x[1]), .y(y[1]), .ci(c1), .z(z[1]), .co(c0));
endmodule

module add2b_tb;
    reg [1:0] x, y;
    reg ci;

    wire [1:0] z;
    wire co;

    add2b dut(.x(x), .y(y), .ci(ci), .z(z), .co(co));

    integer i;
    initial begin
        $monitor("%4t\t%b\t%b\t%b\t||\t%b\t%b", $time, x, y, ci, z, co);
        for(i = 0; i < 32; i = i + 1) begin
            {x, y, ci} = i; #10;
        end
    end

endmodule