module mux_1s_1b_tb(
    output reg s,d0,d1,
    output o
);

mux_1s_1b DUT (.s(s),.d0(d0),.d1(d1),.o(o));
integer  i;
initial begin
    {s,d0,d1} = 3'b0;
    for(i=0;i<8;i=i+1)
    #20 {s,d0,d1} = i[2:0];
end
endmodule