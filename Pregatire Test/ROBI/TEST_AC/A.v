module a(input x, y, output p, g, e);
  assign p = x | y;
  assign g = x & y;
  assign e = x ^ y;
endmodule
//30 secunde