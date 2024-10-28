library verilog;
use verilog.vl_types.all;
entity dec_2x4_tb is
    port(
        s               : out    vl_logic_vector(1 downto 0);
        e               : out    vl_logic;
        o               : out    vl_logic_vector(3 downto 0)
    );
end dec_2x4_tb;
