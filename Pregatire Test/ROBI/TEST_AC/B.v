module b(input g2, p2, g1, p1, output g, p);
  assign g = g2 | (p2 & g1);
  assign p = p2 & p1;
endmodule
//30 secunde