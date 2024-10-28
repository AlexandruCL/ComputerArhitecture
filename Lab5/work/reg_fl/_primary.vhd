library verilog;
use verilog.vl_types.all;
entity reg_fl is
    port(
        wr_data         : in     vl_logic_vector(7 downto 0);
        wr_addr         : in     vl_logic_vector(1 downto 0);
        rd_addr         : in     vl_logic_vector(1 downto 0);
        wr_e            : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        rd_data         : out    vl_logic_vector(7 downto 0)
    );
end reg_fl;
