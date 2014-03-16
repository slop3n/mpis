library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_counter_3digits is
    port(clock: in std_logic; reset: in std_logic; 
        bcd0: out unsigned(3 downto 0); -- least-significat digit
        bcd1: out unsigned(3 downto 0); 
        bcd2: out unsigned(3 downto 0)); -- most-significat digit
end bcd_counter_3digits;

architecture behavioral of bcd_counter_3digits is
    -- TODO
begin

  -- TODO

end behavioral;

