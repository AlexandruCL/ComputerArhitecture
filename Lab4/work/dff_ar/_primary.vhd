library verilog;
use verilog.vl_types.all;
entity dff_ar is
    port(
        d               : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        q               : out    vl_logic
    );
end dff_ar;
