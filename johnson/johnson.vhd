library ieee;
use ieee.std_logic_1164.all;

entity johnson is
    generic( SIZE: natural );
    port( 
        clock: in std_logic;
        reset: in std_logic;
        reg: out std_logic_vector (SIZE-1 downto 0)
    );
end johnson;

architecture behavioral of johnson is
    signal reg_int: std_logic_vector(SIZE-1 downto 0);
begin
    reg <= reg_int;
    process (clock, reset)
    begin
        if( reset = '1') then
            reg_int <= (others=>'0');
        elsif rising_edge(clock) then
            reg_int <= reg_int(SIZE-2 downto 0) & not reg_int(SIZE-1);
        end if;
    end process;
end behavioral;