library verilog;
use verilog.vl_types.all;
entity reg_parl_2b is
    port(
        ld              : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        d               : in     vl_logic_vector(1 downto 0);
        q               : out    vl_logic_vector(1 downto 0)
    );
end reg_parl_2b;
