library verilog;
use verilog.vl_types.all;
entity sadd is
    port(
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        x               : in     vl_logic;
        y               : in     vl_logic;
        z               : out    vl_logic
    );
end sadd;
