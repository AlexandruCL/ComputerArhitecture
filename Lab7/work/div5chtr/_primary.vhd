library verilog;
use verilog.vl_types.all;
entity div5chtr is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        clr             : in     vl_logic;
        cl_up           : in     vl_logic;
        dclk            : out    vl_logic
    );
end div5chtr;
