module ex1b(input a,b,c,d, output f2);

    assign f2 = assign f1 = ((~a) & (~c)) | (a & (~b)) | (b & c);
endmodule

module ex1b_tb;

    reg a,b,c,d;
    wire f2;

    ex1b i0(.a(a), .b(b), .c(c), .d(d), .f2(f2));
    integer k;

    initial begin
   $display("Time\ta\tb\tc\tabcd_10\f1");
   $monitor("0t\t%b\t%b\t%b\t%0d\t%b", $time, a, b, c, {a, b, c}, f1);
   {a, b, c, d} = 0;
   for(k = 1; k < 16; k = k + 1)
        #10 {a, b, c, d} = k;

end
endmodule