library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_counter is
    port( clock : in  std_logic; reset: in std_logic; q : out  unsigned (3 downto 0) );
end bcd_counter;

architecture with_variable of bcd_counter is	
begin
    counter: process( clock, reset )
       variable temp : unsigned (3 downto 0);
    begin
        if( reset = '1') then
            temp := "0000";
        elsif rising_edge( clock ) then
            temp := temp + 1;
            if( temp = "1010" ) then
                temp := "0000";
            end if;
        end if;
        q <= temp;
    end process;
end with_variable;

architecture with_signal of bcd_counter is
	signal temp : unsigned (3 downto 0);
begin
    counter: process( clock, reset ) 
    begin
        if( reset = '1') then
            temp <= "0000";
        elsif rising_edge( clock ) then
            temp <= temp + 1;
            if( temp = "1010" ) then
                temp <= "0000";
            end if;
        end if;
    end process;
    q <= temp;
end with_signal;

