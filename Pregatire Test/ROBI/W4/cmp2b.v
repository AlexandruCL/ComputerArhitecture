// Design a module cmp2b for comparison of 2-bit unsigned numbers,
// having 2, 2-bit inputs, x and y, for the 2 numbers to compare and
// 3 1-bit outputs: eq(equal), lt(less than) and gt(greater than).
// Write your code in file cmp2b.v.


module cmp2b(input [1:0] x, y, output reg eq, lt, gt);
    always @(*) begin
        
        if(x == y)              begin  eq = 1;  lt = 0;  gt = 0;end
        else if(x < y)          begin  eq = 0;  lt = 1;  gt = 0;end
        else                    begin  eq = 0;  lt = 0;  gt = 1;end
    end
endmodule

module cmp2b_tb;
    reg [1:0] x, y;
    wire eq,lt,gt;

    cmp2b i0(.x(x), .y(y), .eq(eq), .lt(lt), .gt(gt));
    integer i,j;
    initial begin
        $display("Time\tX\tY\tEQ\tLT\tGT");
        $monitor("%4t\t%b\t%b\t%b\t%b\t%b", $time, x,y,eq,lt,gt);
        for(i = 0; i < 4; i = i + 1) begin
            for(j = 0; j < 4; j = j + 1) begin
                x = i;
                y = j;
                #10;
            end
        end
    end
endmodule