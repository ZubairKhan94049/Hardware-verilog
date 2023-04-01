library verilog;
use verilog.vl_types.all;
entity notgate is
    port(
        a               : in     vl_logic;
        b               : out    vl_logic
    );
end notgate;
