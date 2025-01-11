//varianta daca ne pune sa facem cu bitwise operators

module rtu2_p1(input [5:0] i, output [2:0] o, output v);

    assign o[2] = (i[0] & (~i[5]) & (~i[4])) | (~i[5] & (~i[4]) & (~i[3]) & i[2] & (~i[1]) & (~i[0]));
    assign o[1] = (~i[5] & ~i[4] & i[0]) | (i[5] & ~i[4]);
    assign o[0] = (i[5] & ~i[4]) | (~i[5] & ~i[4] & i[3] & ~i[1] & ~i[0]) | (~i[5] & ~i[4] & ~i[3] & i[1] & ~i[0]);
    assign v = i[4] | i[5] | i[0] | i[3] | i[1] | i[2]; 

endmodule

module rtu2_p1_tb;

    reg [5:0] i;  // 6-bit input
    wire [2:0] o; // 3-bit output
    wire v;       // 1-bit valid signal

    // Instantiate the module
    rtu2_p1 rtu2_p1_i(.i(i), .o(o), .v(v));

    integer k;

    initial begin 
        $display("Time\ti\t\t  o\t\tv");
        $monitor("%0t\t%b\t%b\t%b", $time, i, o, v);
        i = 0;

        // Exhaustive testing for all possible input combinations
        for (k = 0; k < 64; k = k + 1)
            #10 i = k; // Wait for 10 time units before the next iteration
    end

endmodule


//varianta daca nu ne zice explicit cum sa facem

//   always @(*) begin
//     o = 3'b000;
//     v = 0;

//     if(i[4] == 1)           begin o = 3'b000; v = 1'b1; end
//     else if(i[5])           begin o = 3'b011; v = 1'b1; end
//     else if(i[0])           begin o = 3'b110; v = 1'b1; end
//     else if(i[3] && !i[1])  begin o = 3'b001; v = 1'b1; end
//     else if(!i[3] && i[1])  begin o = 3'b001; v = 1'b1; end
//     else if(i == 4)         begin o = 3'b100; v = 1'b1; end
//   end

//   always @(i) begin
//     //puneti niste valori initiale
//     o = 3'b000;
//     v = 1'b0;
//     //aici transpuneti efectiv tabelul
//     case(i)
//     6'b000000: begin o = 3'b000; v = 1'b0; end // 6'b inseamna numar in binar pe lungime de 6
//     6'b?1????: begin o = 3'b000; v = 1'b1; end // daca are ? inseamna ca i don t care gen * din tabel
//     6'b10????: begin o = 3'b011; v = 1'b1; end
//     6'b00???1: begin o = 3'b110; v = 1'b1; end
//     6'b001?00: begin o = 3'b001; v = 1'b1; end
//     6'b000?10: begin o = 3'b001; v = 1'b1; end
//     6'b001?10: begin o = 3'b000; v = 1'b0; end
//     6'b000100: begin o = 3'b100; v = 1'b1; end
//     endcase 
//   end