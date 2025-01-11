module b(input g1, g2, p1, p2, output g, p);

assign p = p1 & p2;
assign g = g2 | (g1 & p2);

endmodule