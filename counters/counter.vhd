library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity counter is
    generic (N: integer := 4);
    port ( clock : in  std_logic; reset : in  std_logic; q : out  unsigned (N-1 downto 0));
end counter;
 
architecture behavioral of counter is
    signal temp : unsigned(N-1 downto 0);
    constant INITIAL_STATE : unsigned (N-1 downto 0) := (others=>'0');
begin
    process(clock, reset) 
    begin
        if( reset = '1') then
            temp <= INITIAL_STATE;
        elsif rising_edge(clock) then
            temp <= temp + 1;
        end if;
    end process;
    q <= temp;
end behavioral;