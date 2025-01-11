// Build a module for addition of two integers represented in C1,
// called c1 add4b which has 2, 4-bit inputs x, y and a 1-bit input ci
// generating at its output signals z on 4 bits (no carry out because
// of the end around carry).
// Construct a testbench module for exhaustive verification of your
// implementation, called c1add4b tb and the associated script file
// run c1add4b.txt.

module c1_add4b(input [3:0] x, y, input ci, output [3:0] z);
    wire [4:0] sum;
    assign sum = x + y + ci;
    assign z = sum[3:0] + sum[4];
endmodule

module c1_add4b_tb;
    reg [3:0] x, y;      
    reg ci;              
    wire [3:0] z;        
    
    c1_add4b uut(.x(x), .y(y), .ci(ci), .z(z));
    
    integer i, j;

    initial begin
        $display("Time\tX\tY\tCI\tZ");
        $monitor("%4t\t%b\t%b\t%b\t%b", $time, x, y, ci, z);
        
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                x = i;
                y = j;
                ci = 0; 
                #5;     
                ci = 1;  
                #5;     
            end
        end
    end
endmodule

