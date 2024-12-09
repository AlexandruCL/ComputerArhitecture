module sigma_boy(
  
  input[31:0]i,
  output [31:0]o);
  
 assign o =  {i[6:0], i[31:7]} ^ {i[17:0], i[31:18]} ^ {3'd0, i[31:3]};

endmodule

module sigma_boy2(
   
   input[31:0]i,
  output [31:0]o);
  
 assign o =  {i[16:0], i[31:17]} ^ {i[18:0], i[31:19]} ^ {10'd0, i[31:10]};

endmodule

// module sigma_boy3

//     wire [511:0] a, b; wire [31:0] s0, s1, s; assign s = b[511:480] + b0 + b[223:192] + s1; mux # (.w(32)) multiplexers[15:0] (.i1(blk), .i0({b[479:0],s}), .s(ld_rgs), .o(a)); rgst # (.w(32)) registers[15:0] (.clk(clk), .rst_b(rst_b), .d(a), .ld(upd_rgs), clr(1’d0), .q(b)); ssgm_0 sigma0 (.i(b[479:448]), .o(s0)); ssgm_1 sigma1 (.i(b[63:32], .o(s1)));
//     assign wo = b[511:480];

// endmodule
