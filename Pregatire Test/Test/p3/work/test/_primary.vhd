library verilog;
use verilog.vl_types.all;
entity test is
    port(
        clk             : out    vl_logic;
        rst_b           : out    vl_logic;
        a               : out    vl_logic;
        b               : out    vl_logic;
        c               : out    vl_logic;
        m               : out    vl_logic;
        n               : out    vl_logic;
        p               : out    vl_logic
    );
end test;
