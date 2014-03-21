library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mpis.all;

entity bcd_adder is
    generic( N: positive := 3);
    port(a, b: in bcd_number(N-1 downto 0);
        s: out bcd_number(N downto 0));
end bcd_adder;

architecture v1 of bcd_adder is  
begin
    -- TODO
end v1;

