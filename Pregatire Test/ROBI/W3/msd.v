
// Design a Verilog module named msd, using always blocks, having
// one input i on 5 bits and one output o on 4 bits. Output o is the
// value of the most significant decimal digit in input i’s unsigned
// number decimal representation. Example: i = 23 → o = 2;
// i = 9 → o = 9.

module msd(input [4:0] i, output reg [3:0] o);

    always @(*)
        if(i < 10)  o = i;
        else        o = i/10;
endmodule

module msd_tb;
  reg [4:0] i;
  wire [3:0] o;

  msd msd_i (.i(i), .o(o));

  integer k;
  initial begin
    $display("Time\ti\t\to");
    $monitor("%0t\t%b(%2d)\t%b(%0d)", $time, i, i, o, o);
    i = 0;
    for (k = 1; k < 32; k = k + 1)
      #10 i = k;
  end
endmodule


