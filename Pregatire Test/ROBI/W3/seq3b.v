// Design a device named seq3b having an input i on 4 bits and an
// output o on a single bit. The output is active if the binary number
// connected at the input contains a sequence of 3 or more
// consecutive bits with the same value. Example: i = 14 → o = 1;
// i = 9 → o = 0.

module seq3b(input [3:0] i, output reg o);

always @(*)
    if(i[0] == i[1] && i[1] == i[2] || i[1] == i[2] && i[2] == i[3])
        o = 1;
    else o = 0;
endmodule

module seq3b_tb;
  reg [3:0] i;
  wire o;

  seq3b seq3b_i (.i(i), .o(o));

  integer k;
  initial begin
    $display("Time\ti\t\to");
    $monitor("%0t\t%b(%2d)\t%b", $time, i, i, o);
    i = 0;
    for (k = 1; k < 16; k = k + 1)
      #10 i = k;
  end
endmodule