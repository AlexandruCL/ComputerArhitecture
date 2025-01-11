library verilog;
use verilog.vl_types.all;
entity lfsr is
    port(
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        \out\           : out    vl_logic_vector(8 downto 0)
    );
end lfsr;
