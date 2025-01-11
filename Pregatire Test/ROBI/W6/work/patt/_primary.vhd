library verilog;
use verilog.vl_types.all;
entity patt is
    port(
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        start           : in     vl_logic;
        x               : in     vl_logic_vector(3 downto 0);
        y               : in     vl_logic_vector(3 downto 0);
        z               : out    vl_logic_vector(3 downto 0);
        done            : out    vl_logic
    );
end patt;
