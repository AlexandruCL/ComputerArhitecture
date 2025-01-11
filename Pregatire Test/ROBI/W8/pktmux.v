module pktmux(input pad_pkt, zero_pkt, mgln_pkt, input [63:0] msg_len, pkt, output reg [63:0] o);
    always @(*)
        if(pad_pkt)             o = (1 << 63);
        else if(zero_pkt)       o = 0;
        else if(mgln_pkt)       o = msg_len;
        else                    o = pkt;
endmodule

module pktmux_tb;
    reg pad_pkt, zero_pkt, mgln_pkt;
    reg [63:0] msg_len, pkt;
    
    wire [63:0] o;

    pktmux i0(.pad_pkt(pad_pkt), .zero_pkt(zero_pkt), .mgln_pkt(mgln_pkt), .msg_len(msg_len), .pkt(pkt), .o(o));

    task urand64(output reg [63:0] r);
        begin
            r[63:32] = $urandom;
            r[31:0] = $urandom;
        end
    endtask

    initial begin
        repeat(3) begin
            {pad_pkt, zero_pkt, mgln_pkt} = 'b000; #100;
            {pad_pkt, zero_pkt, mgln_pkt} = 'b100; #100;
            {pad_pkt, zero_pkt, mgln_pkt} = 'b010; #100;
            {pad_pkt, zero_pkt, mgln_pkt} = 'b001; #100;
        end
        {pad_pkt, zero_pkt, mgln_pkt} = 'b000; #100;
    end
    initial begin
        repeat(13) begin
            urand64(msg_len); urand64(pkt); #100;
        end
    end
endmodule