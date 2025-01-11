module fsm(
  input clk,
  input rst_b,  //asynch
  input i,
  output reg o
);

  localparam S0 = 3'd0;
  localparam S1 = 3'd1;
  localparam S2 = 3'd2;
  localparam S3 = 3'd3;
  localparam S4 = 3'd4;
  localparam S5 = 3'd5;
  
  reg [2:0] st;
  reg [2:0] st_nxt;

  always @ (*)
    case (st)
      S0: st_nxt = (i) ? S1 : S0;
      S1: st_nxt = (i) ? S1 : S2;
      S2: st_nxt = (i) ? S3 : S0;
      S3: st_nxt = (i) ? S4 : S2;
      S4: st_nxt = (i) ? S1 : S5;
      S5: st_nxt = S0;
      default: st_nxt = S0;
    endcase

  always @ (*)
    if (st == S5) o=1'd1;
    else o = 1'd0; 
  
  always @ (posedge clk or negedge rst_b) 
    if (!rst_b) st <= S0;
    else st<= st_nxt;
endmodule
