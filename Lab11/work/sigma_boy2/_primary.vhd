library verilog;
use verilog.vl_types.all;
entity sigma_boy2 is
    port(
        i               : in     vl_logic_vector(31 downto 0);
        o               : out    vl_logic_vector(31 downto 0)
    );
end sigma_boy2;
