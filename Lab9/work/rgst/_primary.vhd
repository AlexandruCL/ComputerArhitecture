library verilog;
use verilog.vl_types.all;
entity rgst is
    generic(
        w               : integer := 64
    );
    port(
        d               : in     vl_logic_vector;
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        rst             : in     vl_logic;
        ld              : in     vl_logic;
        q               : out    vl_logic_vector
    );
end rgst;
