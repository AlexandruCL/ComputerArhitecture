library verilog;
use verilog.vl_types.all;
entity counter_4b is
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        c_up            : in     vl_logic;
        rst             : in     vl_logic;
        q               : out    vl_logic_vector(3 downto 0)
    );
end counter_4b;
