library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port ( 
        clk50: in std_logic;
        reset: in std_logic;
        led: out std_logic_vector (7 downto 0)
    );
end top;

architecture structural of top is
   signal clock: std_logic;
begin

    U1: entity work.johnson 
    generic map (SIZE => 8)
    port map(
        clock => clock,
        reset => reset,
        reg => led
    );
   
    U2: entity work.clock_divider
    generic map (N=>23)
    port map(
        clock_in => clk50,
        clock_out => clock,
        reset => reset
    );
end structural;