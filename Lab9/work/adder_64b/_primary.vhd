library verilog;
use verilog.vl_types.all;
entity adder_64b is
    port(
        x               : in     vl_logic_vector(63 downto 0);
        y               : in     vl_logic_vector(63 downto 0);
        z               : out    vl_logic_vector(63 downto 0)
    );
end adder_64b;
