module bist(
  input clk, rst,set,
  output reg [0:3]q);
  
  wire [0:3]w1;
  wire w2;
  
  lfsr_4b tpg(.clk(clk), .set(set), .rst(1'b1), .q(w1));
  checker dut(.i(w1), .o(w2));
  sisr ora(.i(w2), .clk(clk), .rst(rst), .q(q), .set(1'b1));

endmodule;