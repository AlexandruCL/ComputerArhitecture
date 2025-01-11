//metoda ONE HOT ENCODING
module rtu2_p2(input clk, rst_b, a, b, output p, m, n);

localparam S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
reg [4: 0] st;
wire [4:0] st_nxt;

// assign st_nxt[S0] = 0;
assign st_nxt[S1] = (st[0] & ~a ) | (st[0] & a) | (st[3] & b);
assign st_nxt[S2] = (st[2] & (~a & ~b)) | (st[1] & b);
assign st_nxt[S3] = (st[3] & ~b) | (st[2] & (a | b)) | (st[1] & (a & ~b)) | (st[4] & ?);
assign st_nxt[S4] = (st[1] & (~a & ~b));

assign m = (st[1] & a) | (st[2] & (~a & ~b)) | (st[3] & (a & ~b)) | (st[4] & (~a & ~b));
assign n = (st[3] & (a & ~b)) | (st[2] & b) | (st[3] & (a | b)) | (st[3] | ?);
assign p = (st[1] & ~a) | (st[2] & (~a & ~b)) | (st[3] & ~b);

  always @(posedge clk, negedge rst_b) begin
    if(!rst_b) begin
      st     <= 0;
      st[S0] <= 1;
    end
    else
      st <= st_next;
  end


endmodule

module fsm_tb;

    reg clk, reset, a, b;
    wire p, m, n;

    // Instantiate the FSM
    fsm uut (
        .clk(clk),
        .reset(reset),
        .a(a),
        .b(b),
        .p(p),
        .m(m),
        .n(n)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units clock period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1; a = 0; b = 0;
        #10 reset = 0;

        // Test sequence for p, m, n, p, p, p
        #10 a = 0; b = 0; // Expect p
        #10 a = 1; b = 0; // Expect m
        #10 a = 1; b = 1; // Expect n
        #10 a = 0; b = 1; // Expect p
        #10 a = 0; b = 0; // Expect p
        #10 a = 0; b = 0; // Expect p

        #10 $finish;
    end
endmodule

// module fsm(
//   input clk,
//   input rst_b,  //asynch
//   input a, b,
//   output reg m, n, p
// );


//   // Metoda simpla, aici m,n,p sunt reg.
  
//   //declarati toate starile
//   localparam S0 = 0;
//   localparam S1 = 1;
//   localparam S2 = 2;
//   localparam S3 = 3;
//   localparam S4 = 4;

//   reg [4:0] st;
//   reg [4:0] st_next;

//   always @(*) begin
//     case(st)
//       S0: if(a | ~a)              st_next = S1;
//       S1: if(b)                   st_next = S2;
//           else if(a)              st_next = S3;
//           else if(~a)             st_next = S4;
//       S2: if(a|b)                 st_next = S3;
//           else if(~a & ~b)        st_next = S2;
//       S3: if(b)                   st_next = S1;
//           else                    st_next = S3;
//       S4:                         st_next = S3;
//     endcase
//   end

//   always @(*) begin
//     m = 0; n = 0; p = 0;
//     case(st)
//       S0: if(a)            m = 1;
//           else             p = 1;
//       S1: if(b)            n = 1;
//           else if(a)       begin m = 1; n = 1; end
//           else             m = 1;
//       S2: if(a|b)          n = 1;
//           else if(~a & ~b) begin m = 1; p = 1; end
//       S3: if(~b)           p = 1;
//       S4:                  n = 1;
//     endcase
//   end

//   always @(posedge clk, negedge rst_b) begin
//     if(!rst_b) st <= S0;
//     else       st <= st_next;
//   end



// module fdivby3_tb();
//     reg clk, rst_b, clr, c_up;
//     wire fdclk;

//     fdivby3 hey(.clk(clk), .rst_b(rst_b), .clr(clr), .c_up(c_up), .fdclk(fdclk));

//     localparam CLK_PERIOD = 100;
//     localparam CLK_CYCLES = 17;

//     initial begin
//         clk = 0;
//         repeat (2*CLK_CYCLES) #(CLK_PERIOD/2)   clk = 1 - clk;
//     end

//     localparam RST_DURATION = 25;

//     initial begin
//         rst_b = 0;
//         #RST_DURATION
//         rst_b = 1;
//     end

//     initial begin
//                 clr = 0;
//         #400    clr = 1;
//         #100    clr = 0;
//     end

//     initial begin
//                 c_up = 1;
//         #600    c_up = 0;
//         #100    c_up = 1;
//         #400    c_up = 0;
//         #200    c_up = 1;
//     end
// endmodule


































