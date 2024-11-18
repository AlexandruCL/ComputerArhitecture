module dflipflop(
    input d,rst,set,clk,
    output reg q
);  

always @(posedge clk , negedge rst, negedge set ) begin
   if(rst == 0) begin
       q <= 1'b0;
   end
   else if(set == 0) begin
       q <= 1'b1;
   end
   else begin
       q <= d;
   end
end
endmodule