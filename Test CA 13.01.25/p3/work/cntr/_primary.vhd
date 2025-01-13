library verilog;
use verilog.vl_types.all;
entity cntr is
    generic(
        WIDTH           : integer := 8
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        en              : in     vl_logic;
        count           : out    vl_logic_vector
    );
end cntr;
