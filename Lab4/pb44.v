module mux_1s_1b(
    input s,d0,d1,
    output reg o
);
always @(*) //* means that the it takes all inputs in the sensitivity list
    begin
        if(s)
            o <= d1;
        else
            o <= d0;
    end
endmodule


module reg_parl_2b(
    input ld,clk,rst,
    input [1:0]d,
    output [1:0]q
);
    mux_1s_1b M1(.s(ld),.d1(d[1]),.d0(q[1]),.o(w1));
    mux_1s_1b M2(.s(ld),.d1(d[0]),.d0(q[0]),.o(w2));
    dff_ar D1(.d(w1),.clk(clk),.rst(rst),.q(q[1]));
    dff_ar D2(.d(w2),.clk(clk),.rst(rst),.q(q[0]));
endmodule