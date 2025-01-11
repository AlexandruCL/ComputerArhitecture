module comb(input [5:0] i, output reg [2:0] o, output reg v);

    always @(*) begin
        
        o = 3'b000;
        v = 1'b0;

        case(i)
            6'b?1????: begin o = 3'b000; v = 1'b1; end
            6'b10????: begin o = 3'b000; v = 1'b1; end
            6'b00???1: begin o = 3'b011; v = 1'b1; end
            6'b001?00: begin o = 3'b001; v = 1'b1; end
            6'b000?10: begin o = 3'b000; v = 1'b1; end
            6'b001?10: begin o = 3'b000; v = 1'b0; end
            6'b000100: begin o = 3'b100; v = 1'b1; end
        endcase
    end
endmodule

module comb_tb;

    reg [5:0] i;
    wire [2:0] o;
    wire v;

    comb dut(.i(i), .o(o), .v(v));

    integer k;

    initial begin
        $display("Time\ti\to\tv");
        $monitor("%0t\t%b\t%b\t%b", $time, i, o, v);
        i = 0;
        for(k = 1; k < 64; k = k + 1)
            #10 i = k;
    end
endmodule

/*
module comb(
    input [5:0] i,          // 6-bit input
    output reg [2:0] o,     // 3-bit output
    output reg v            // 1-bit valid flag
);
    always @(*) begin
        // Default outputs
        o = 3'b000;
        v = 1'b0;

        // Truth table logic
        case (1'b1)  // Use priority encoding for conditions
            (i[5] == 1'b1): begin
                o = 3'b000;
                v = 1'b1;
            end
            (i[4] == 1'b1): begin
                o = 3'b000;
                v = 1'b1;
            end
            (i[0] == 1'b1 && i[3:1] == 3'b000): begin
                o = 3'b011;
                v = 1'b1;
            end
            (i[3] == 1'b1 && i[1:0] == 2'b00): begin
                o = 3'b001;
                v = 1'b1;
            end
            (i[1] == 1'b1 && i[0] == 1'b0): begin
                o = 3'b000;
                v = 1'b1;
            end
            (i[3] == 1'b1 && i[1:0] == 2'b10): begin
                o = 3'b000;
                v = 1'b0;
            end
            (i == 6'b000100): begin
                o = 3'b100;
                v = 1'b1;
            end
        endcase
    end
endmodule

module comb_tb;

    reg [5:0] i;            // Test input
    wire [2:0] o;           // Observed output
    wire v;                 // Observed valid flag

    // Instantiate the DUT (Device Under Test)
    comb dut(.i(i), .o(o), .v(v));

    integer k;

    initial begin
        $display("Time\ti       \to   \tv");
        $monitor("%0t\t%b\t%b\t%b", $time, i, o, v);

        // Iterate through all input combinations
        for (k = 0; k < 64; k = k + 1) begin
            i = k;   // Assign test input
            #10;     // Wait 10 time units
        end

        $finish; // End simulation
    end
endmodule

*/

/*
module prenc(
  input [5:0] i,
  output [2:0] o,
  output v
);




assign o = (i==0) ? 0:
            (i[4]==1)? 0:
            (i[5]==1 & i[4]==0) ? 2'b011:
            (i[5]==0 & i[4]==0 & i[0]==1) ? 2'b110:
            (i[5]==0 & i[4]==0 & i[3]==1 & i[1]==0 & i[0]==0)  ? 2'b001 :
            (i[5]==0 & i[4]==0 & i[3]==0 & i[1]==1 & i[0]==0) ? 2'b001 :
            (i[5]==0 & i[4]==0 & i[3]==1 & i[1]==1 & i[0]==0) ? 0 :
            (i[5]==0 & i[4]==0 & i[3]==0 & i[2]==1 & i[1]==0 & i[0]==0) ? 2'b100 : 2'b0000;

assign v = (i==0) ? 0:
            (i[4]==1)? 1:
            (i[5]==1 & i[4]==0) ? 1:
            (i[5]==0 & i[4]==0 &i[0]==1) ? 1:
            (i[5]==0 & i[4]==0 & i[3]==1 & i[1]==0 & i[0]==0)  ? 1 :
            (i[5]==0 & i[4]==0 & i[3]==0 & i[1]==1 & i[0]==0) ? 1 :
            (i[5]==0 & i[4]==0 & i[3]==1 & i[1]==1 & i[0]==0) ? 0 :
            (i[5]==0 & i[4]==0 & i[3]==0 & i[2]==1 & i[1]==0 & i[0]==0) ? 1 : 2'b0000;


endmodule

*/