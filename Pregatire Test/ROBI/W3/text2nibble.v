// Design module text2nibble, having input i on 8 bits and outputo
// on 4 bits. Input i receives one ASCII character. If the character is
// a decimal digit (’0’ to ’9’), provided at output the value of the
// digit, otherwise provide value 15.

module text2nibble(input [7:0] i, output reg [3:0] o);

    always @(*) begin
        
        case(i)

            8'h30:      o = 0;
            8'h31:      o = 1;
            8'h32:      o = 2;
            8'h33:      o = 3;
            8'h34:      o = 4;
            8'h35:      o = 5;
            8'h36:      o = 6;
            8'h37:      o = 7;
            8'h38:      o = 8;
            8'h39:      o = 9;
            default:    o = 15;
        endcase
    end 
endmodule


module text2nibble_tb;
  reg [7:0] i;
  wire [3:0] o;

  text2nibble text2nibble_i (.i(i), .o(o));

  integer k;
  initial begin
    $display("Time\ti\ti_chr\to");
    $monitor("%0t\t%b\t%c\t%b(%d)", $time, i, i, o, o);
    i = 0;
    for (k = 1; k < 256; k = k + 1)
      #10 i = k;
  end
endmodule