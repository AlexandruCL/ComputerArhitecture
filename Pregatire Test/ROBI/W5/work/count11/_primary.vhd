library verilog;
use verilog.vl_types.all;
entity count11 is
    generic(
        width           : integer := 4;
        initial_value   : integer := 0
    );
    port(
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        c_up            : in     vl_logic;
        q               : out    vl_logic_vector
    );
end count11;
