module adder_64b(
    input [63:0] x,y,
    output [63:0] z
);
assign z = x + y;
endmodule

module rgst#(parameter w = 64, parameter iw = {w{1'b0}})(
    input [w-1:0] d,
    input clk, clr, rst, ld,
    output reg [w-1:0] q
);

always@(posedge clk, negedge rst) begin
    if(!rst || clk)
        q <= iw;
    else if(ld)
        q <= d;
end
endmodule

module counter_4b(
    input clk, clr, c_up,rst,
    output reg [3:0] q
);

always @ (posedge clk, negedge clr) begin
    if(!rst)
        q <= 4'b0000;
    else if (clr) 
        q <= 4'd0;
    else if (c_up)  
        q <= q+1;       //4'b0001;
end
endmodule

module pkt_mux (
    input [31:0] pkt,        // Input packet from the message
    input [63:0] msg_len,    // Message length
    input pad_pkt,           // Padding packet selection
    input zero_pkt,          // Zero packet selection
    input hi_mgln,           // Most significant half of msg_len
    input lo_mgln,           // Least significant half of msg_len
    output reg [31:0] pkt_out // Output selected packet
);

    always @(*) begin
        if (pad_pkt)
            pkt_out = {1'b1, 31'd0}; // Padding packet
        else if (zero_pkt)
            pkt_out = 32'd0;
        else if (hi_mgln)
            pkt_out = msg_len[63:32]; // High 32 bits of msg_len
        else if (lo_mgln)
            pkt_out = msg_len[31:0]; // Low 32 bits of msg_len
        else
            pkt_out = pkt; // Default: pass the input message packet
    end
endmodule

module pre_processing_unit(
    
    input st_pkt, lo_mgln, hi_mgln, zero_pkt, pad_pkt, inc_mgln, clr, c_up, clk, rst,
    input [31:0]pkt,
    output [3:0] ldx,
    output [511:0]blk);
    
    wire [31:0] mux_o;
    wire [63:0] adder_o;
    wire [3:0]counter_o;
    wire[63:0]rgst_o;
    
    
    adder_64b adder1(.x(64'd32), .y(rgst_o), .z(adder_o));
    rgst #(.w(64)) rgst1(.d(adder_o), .ld(inc_mgln), .clr(clr), .clk(clk), .q(rgst_o));
    counter_4b counter1(.clk(clk), .clr(clr), .c_up(c_up), .rst(rst), .q(counter_o));
    
    pkt_mux mux(.msg_len( rgst_o), .pkt(pkt), .pad_pkt(pad_pkt), .zero_pkt(zero_pkt), .hi_mgln(hi_mgln), .lo_mgln(lo_mgln), .o(mux_o));
    
    //mai trebuie instantiat mistery block ul
    
endmodule;  