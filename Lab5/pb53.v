module rgst # (parameter w = 8, parameter iv = {w{1'b0}})(
    input clk, rst, clear, load,
    input [w-1:0]d,
    output reg [w-1:0]q
);

always@(posedge clk, negedge rst) 
begin
    if(!rst || clear)
        q<=iv;
    else if(clk)
        if(load)
            q<=d;
end
endmodule