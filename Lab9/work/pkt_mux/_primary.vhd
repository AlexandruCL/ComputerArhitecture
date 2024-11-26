library verilog;
use verilog.vl_types.all;
entity pkt_mux is
    port(
        pkt             : in     vl_logic_vector(31 downto 0);
        msg_len         : in     vl_logic_vector(63 downto 0);
        pad_pkt         : in     vl_logic;
        zero_pkt        : in     vl_logic;
        hi_mgln         : in     vl_logic;
        lo_mgln         : in     vl_logic;
        pkt_out         : out    vl_logic_vector(31 downto 0)
    );
end pkt_mux;
