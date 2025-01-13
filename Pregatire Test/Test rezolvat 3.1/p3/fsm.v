module fsm(
  input clk,
  input rst_b,  // asynchronous reset, active low
  input a, b, c,
  output m, n, p
);

  // State encoding
  localparam S0 = 0;
  localparam S1 = 1;
  localparam S2 = 2;
  localparam S3 = 3;

  reg [3:0] st;
  wire [3:0] st_next;

  // Next state logic
  assign st_next[S0] = (st[S0] & ~a & ~b & ~c) | (st[S1] & ~b & ~c) | (st[S2] & ~a & ~c) | (st[S3] & ~a & ~b);
  assign st_next[S1] = (st[S0] & a) | (st[S1] & b) | (st[S3] & b);
  assign st_next[S2] = (st[S1] & ~a & ~b) | (st[S2] & c);
  assign st_next[S3] = (st[S1] & a & ~b) | (st[S2] & a) | (st[S3] & ~b);

  // Output logic
  assign m = (st[S0] & ~a) | (st[S1] & ~a & ~b) | (st[S1] & a & ~b) | (st[S2] & ~a & ~b);
  assign n = (st[S1] & b) | (st[S1] & a & ~b) | (st[S2] & a | b);
  assign p = (st[S0] & ~a) | (st[S2] & ~a & ~b) | (st[S3] & ~b);

  // State register
  always @(posedge clk or negedge rst_b) begin
    if (!rst_b) begin
      st <= 0;
      st[S0] <= 1;
    end else begin
      st <= st_next;
    end
  end

endmodule