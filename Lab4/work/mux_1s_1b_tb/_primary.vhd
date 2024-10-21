library verilog;
use verilog.vl_types.all;
entity mux_1s_1b_tb is
    port(
        s               : out    vl_logic;
        d0              : out    vl_logic;
        d1              : out    vl_logic;
        o               : out    vl_logic
    );
end mux_1s_1b_tb;
