module a(input x, y, output e, g, p);

    assign e = x ^ y;
    assign g = x & y;
    assign p = x | y;
endmodule