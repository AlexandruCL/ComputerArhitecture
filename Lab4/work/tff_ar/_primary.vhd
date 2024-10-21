library verilog;
use verilog.vl_types.all;
entity tff_ar is
    port(
        t               : in     vl_logic;
        en              : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        q               : out    vl_logic
    );
end tff_ar;
