//finite machines in 5 steps 

module sadd(
   input clk, rst_b,x, y,
   output reg z
);
// 1st step: define the constants 

localparam S0 = 0,  S1 = 1 ;//like a define in C - they stay the same all the time.

//2nd step: define the current state and next state - reg type

reg state, state_next;

//3rd step: generate the next step -  in an always bloc

always @(*) begin
  case (state)
    S0: if(x & y) 
            state_next = S1;
          else
            state_next = S0;
            
    S1: if((!x) & (!y))
            state_next = S0;
          else
            state_next = S1;
    endcase
  end
  
//4th step: generate the outputs - 2 ways: alwyas block or ...(idk)

always @(*) begin
  z = 0;
  case(state)
    S0: if(x^y) z = 1;
          else  z = 0;
            
    S1: if(!(x^y)) z = 0;
          else z = 1;
    
  endcase
end

//5th step: modifying the current state

always @(posedge clk, negedge rst_b) begin
  if( !rst_b) state <= S0;
  else
    state <= state_next;
  end
  
endmodule

module sadd_tb;
reg clk, rst_b, x, y;
wire z;
sadd io(.clk(clk), .rst_b(rst_b), .x(x), .y(y), .z(z));
localparam CLK_PERIOD = 100, CLK_CYCLES = 4, RST_DURATION = 25;
initial begin
    clk = 0; repeat(2*CLK_CYCLES) # (CLK_PERIOD/2) clk = 1-clk; end
initial begin
    rst_b = 0; #(RST_DURATION) rst_b = 1; end

initial begin
    x = 0; y = 1;
    #(1*CLK_PERIOD);
    x = 1; y = 1;
    #(1*CLK_PERIOD);
    x = 1; y = 0;
    #(1*CLK_PERIOD);
    x = 0; y = 0;
    #(1*CLK_PERIOD);
end
endmodule
