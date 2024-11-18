library verilog;
use verilog.vl_types.all;
entity sisr_4b is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        i               : in     vl_logic;
        q               : out    vl_logic_vector(0 to 3)
    );
end sisr_4b;
