library verilog;
use verilog.vl_types.all;
entity adder is
    generic(
        WIDTH           : integer := 8
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        sum             : out    vl_logic_vector
    );
end adder;
