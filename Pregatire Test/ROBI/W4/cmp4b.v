// Using module cmp2b, build a 4-bit comparator, called cmp4b,
// having 2, 4-bit unsigned inputs x and y, for the 2 operands and 3
// 1-bit outputs: eq, lt and gt. Write your code in file cmp4b.v.
// Construct a testbench module for exhaustive verification of your
// implementation, called cmp4b tb and the associated script file
// run cmp4b.txt.

module cmp4b(input [3:0] x, y, output reg eq, lt, gt);

    wire eq1, lt1, gt1; //LSB comparisons outputs
    wire eq2, lt2, gt2; //MSB comparisons outputs

    cmp2b i0(.x(x[1:0]), .y(y[1:0]), .eq(eq1), .lt(lt1), .gt(gt1));
    cmp2b i1(.x(x[3:2]), .y(y[3:2]), .eq(eq2), .lt(lt2), .gt(gt2));

    always @(*) begin
        if(eq2) begin
        //If MSBs are equal, result depends on LSBs
        eq = eq1;
        lt = lt1;
        gt = gt1;
        end
        else begin
        //Otherwise, MSB comparison determines the result
        eq = 0;
        lt = lt2;
        gt = gt2;
    end
    end
endmodule


module cmp4b_tb;
    reg [3:0] x, y;
    wire eq,lt,gt;

    cmp4b i0(.x(x), .y(y), .eq(eq), .lt(lt), .gt(gt));
    integer i,j;
    initial begin
        $display("Time\tX\tY\tEQ\tLT\tGT");
        $monitor("%4t\t%b(%d)\t%b(%d)\t%b\t%b\t%b", $time, x,x,y,y,eq,lt,gt);
        x = 0;
        y = 0;
        #5;
        for(i = 0; i < 16; i = i + 1) begin
            for(j = 0; j < 16; j = j + 1) begin
                x = i;
                y = j;
                #10;
            end
        end
    end
endmodule