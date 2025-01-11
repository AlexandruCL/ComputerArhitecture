module pattdet(
    input i, clk, rst_b,
    output reg o
);
    localparam S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5;

    reg [5:0] st; // 6 stari => pe 6 biti
    reg [5:0] st_next; // daca e cu one hot nu e reg, e wire (doar st_next)

    always @(*) begin
        case(st)
            S0: if(i)   st_next = S1;
                else    st_next = S0;
            S1: if(!i)  st_next = S2;
                else    st_next = S1;
            S2: if(i)   st_next = S3;
                else    st_next = S0;
            S3: if(!i)  st_next = S4;
                else    st_next = S1;
            S4: if(i)   st_next = S5;
                else    st_next = S0;
            S5: if(i)   st_next = S1;
                else    st_next = S4;
        endcase
    end

    always @(*) begin
        o = 0;
        if(st == S5)   o = 1;
        // o = (st == S5);
    end

    always @(posedge clk, negedge rst_b) begin
        if(!rst_b)  st <= S0;
        else        st <= st_next;
    end

endmodule

module pattdet_tb();
  reg clk, rst_b, i;
  wire o;

  pattdet meow(.clk(clk), .rst_b(rst_b), .i(i), .o(o));

  localparam CLK_CYCLES = 10;
  localparam CLK_PERIOD = 100;

  initial begin
    clk = 0;
    repeat(2*CLK_CYCLES) #(CLK_PERIOD/2) clk = 1 - clk;
  end

  localparam RST_DURATION = 25;

  initial begin
    rst_b = 0;
    #RST_DURATION rst_b = 1;
  end

  initial begin
    i = 1; #(1*CLK_PERIOD)
    i = 0; #(1*CLK_PERIOD)
    i = 1; #(1*CLK_PERIOD)
    i = 0; #(1*CLK_PERIOD)
    i = 1; #(1*CLK_PERIOD)
    i = 0; #(1*CLK_PERIOD)
    i = 1; #(1*CLK_PERIOD)
    i = 0; #(1*CLK_PERIOD)
    i = 1;
  end
endmodule