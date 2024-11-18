library verilog;
use verilog.vl_types.all;
entity lfsr_4b is
    port(
        clk             : in     vl_logic;
        set             : in     vl_logic;
        q               : out    vl_logic_vector(0 to 3)
    );
end lfsr_4b;
