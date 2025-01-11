module cl1(
  input x0,
  input x1,
  output a1,
  output b1
);

  assign a1 = x1 ^ x0;
  assign b1 = x1;
endmodule