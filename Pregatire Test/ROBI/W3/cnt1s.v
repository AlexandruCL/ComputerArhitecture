// Construct a device for counting the number of bits of 1 for the
// unsigned number connected at the input i. The module, named
// cnt1s, has an input i, on 6 bits and an output o on the minimum
// required number of bits. Build the module using always blocks.

module cnt1s(input [5:0] i, output reg [2:0] o);

integer j;
    always @(*) begin
        o = 0;
        for(j = 0; j < 6; j = j+1)
            o = o + i[j];
    end
endmodule

module cnt1s_tb;

reg [5:0] i;
wire [2:0] o;

cnt1s cnt1s_i(.i(i), .o(o));

integer k;
initial begin
    $display("Time\ti\t\to");
    $monitor("%0t\t%b(%2d)\t%b(%0d)", $time, i, i, o, o);
    i = 0;
    for (k = 1; k < 64; k = k + 1)
      #10 i = k;
  end
endmodule