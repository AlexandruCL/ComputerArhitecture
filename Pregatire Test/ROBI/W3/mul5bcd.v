// Construct a module named mul5bcd having a 4-bit input i and two
// ouptuts d and u, both on 4 bits. At input i it receives a BCD digit
// (on 4 bits) and the module provides at the output the result of
// multiplying by 5, in BCD, the input digit: the output d represents
// the decimals’ figure while the output u represents the units’ figure
// of the result. Example: i = 3(0011) → d = 1(0001), u = 5(0101);
// i = 9 → d = 4(0100), u = 5(0101).

module mul5bcd(input [3:0] i, output reg [3:0] d, u);

    always @(*) begin
        d = ((i*5)/10)%10;
        u = (i*5)%10;
        end
endmodule

module mul5bcd_tb;
  reg [3:0] i;
  wire [3:0] d, u;

  mul5bcd mul5bcd_i (.i(i), .d(d), .u(u));

  integer k;
  initial begin
    $display("Time\ti\t\td\t\tu");
    $monitor("%0t\t%b(%4d)\t%b(%4d)\t%b(%4d)", $time, i, i, d, d, u, u);
    i = 0;
    for (k = 1; k < 10; k = k + 1)
      #10 i = k;
  end
endmodule