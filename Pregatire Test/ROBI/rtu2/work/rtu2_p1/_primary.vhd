library verilog;
use verilog.vl_types.all;
entity rtu2_p1 is
    port(
        i               : in     vl_logic_vector(5 downto 0);
        o               : out    vl_logic_vector(2 downto 0);
        v               : out    vl_logic
    );
end rtu2_p1;
