module cl2(
  input x1,
  input x2,
  output a2,
  output b2
);

  assign a2 = x2 ^ x1;
  assign b2 = x2;
endmodule