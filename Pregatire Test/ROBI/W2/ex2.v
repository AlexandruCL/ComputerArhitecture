module ex2(input [2:0] i, output o);

assign o = (i == 1) || (i == 5);

endmodule

module ex2_tb;

    reg [2:0] i;
    wire o;

    ex2 i0(.i(i), .o(o));

    integer k;

    initial begin
        
        $display("Time\ti\to");
        $monitor("%0t\t%b\t%b", $time, i, o);
        i = 0;
        for(k = 1; k < 8; k = k + 1)
            #10 i = k;
    end
endmodule