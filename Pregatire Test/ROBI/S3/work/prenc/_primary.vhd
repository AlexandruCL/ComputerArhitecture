library verilog;
use verilog.vl_types.all;
entity prenc is
    port(
        i               : in     vl_logic_vector(5 downto 0);
        o               : out    vl_logic_vector(1 downto 0);
        v               : out    vl_logic
    );
end prenc;
