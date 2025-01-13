// a)
module adder #(parameter WIDTH = 8) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [WIDTH-1:0] sum
);
    assign sum = a + b;
endmodule

//b)
module rgst #(parameter WIDTH = 8) (
    input clk,
    input rst,
    input [WIDTH-1:0] d,
    output reg [WIDTH-1:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 0;
        else
            q <= d;
    end
endmodule

//c)
module cntr #(parameter WIDTH = 8) (
    input clk,
    input rst,
    input en,
    output reg [WIDTH-1:0] count
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 0;
        else if (en)
            count <= count + 1;
    end
endmodule