module multiplier(
  input [2:0] x,
  input [2:0] y,
  output [5:0] p
);

  wire a0;
  wire b0;
  wire a1;
  wire b1;
  wire a2;
  wire b2;

  wire [4:0] w0;
  wire [4:1] c0;
  wire [4:0] w1;
  wire [4:1] c1;
  wire [4:1] c2;

  cl0 ucl0(
    .x0(x[0]),
    .a0(a0),
    .b0(b0)
  );

  cl1 ucl1(
    .x0(x[0]),
    .x1(x[1]),
    .a1(a1),
    .b1(b1)
  );

  cl2 ucl2(
    .x1(x[1]),
    .x2(x[2]),
    .a2(a2),
    .b2(b2)
  );

  assign z[0] = w1[0];
  assign z[1] = w1[1] ^ w0[0];
  assign z[2] = w1[2] ^ c0[1];
  assign z[3] = w1[3] ^ c1[2];
  assign z[4] = w1[4] ^ c2[3];

endmodule