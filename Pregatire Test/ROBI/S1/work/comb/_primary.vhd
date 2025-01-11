library verilog;
use verilog.vl_types.all;
entity comb is
    port(
        i               : in     vl_logic_vector(4 downto 0);
        m               : out    vl_logic;
        n               : out    vl_logic
    );
end comb;
