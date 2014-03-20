library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity johnson is
    generic( SIZE: natural );
    port( 
        clock: in std_logic;
        reset: in std_logic;
        reg: out std_logic_vector (SIZE-1 downto 0)
    );
end johnson;

architecture v1 of johnson is
    signal reg_int: std_logic_vector(SIZE-1 downto 0);
begin
    reg <= reg_int;
    process (clock, reset)
    begin
        if( reset = '1') then
            reg_int <= (others=>'0');
        elsif rising_edge(clock) then
            -- using concatenation
            reg_int <= reg_int(SIZE-2 downto 0) & not reg_int(SIZE-1);
        end if;
    end process;
end v1;

architecture v2 of johnson is
    signal reg_int: std_logic_vector(SIZE-1 downto 0);
begin

    reg <= reg_int;
    
    process (clock, reset)
        variable tmp: std_logic;
    begin
        if( reset = '1') then
            reg_int <= (others=>'0');
        elsif rising_edge(clock) then
            -- using shift functions
            tmp := reg_int(SIZE-1); 
            reg_int <= std_logic_vector(shift_left(unsigned(reg_int), 1));
            reg_int(0) <= not tmp;
        end if;
    end process;
end v2;