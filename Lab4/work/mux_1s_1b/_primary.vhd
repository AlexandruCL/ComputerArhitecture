library verilog;
use verilog.vl_types.all;
entity mux_1s_1b is
    port(
        s               : in     vl_logic;
        d0              : in     vl_logic;
        d1              : in     vl_logic;
        o               : out    vl_logic
    );
end mux_1s_1b;
