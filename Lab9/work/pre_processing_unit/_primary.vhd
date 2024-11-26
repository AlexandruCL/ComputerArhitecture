library verilog;
use verilog.vl_types.all;
entity pre_processing_unit is
    port(
        st_pkt          : in     vl_logic;
        lo_mgln         : in     vl_logic;
        hi_mgln         : in     vl_logic;
        zero_pkt        : in     vl_logic;
        pad_pkt         : in     vl_logic;
        inc_mgln        : in     vl_logic;
        clr             : in     vl_logic;
        c_up            : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        pkt             : in     vl_logic_vector(31 downto 0);
        ldx             : out    vl_logic_vector(3 downto 0);
        blk             : out    vl_logic_vector(511 downto 0)
    );
end pre_processing_unit;
