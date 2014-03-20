library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity johnson is
    generic( N: natural );
    port( clock, reset: in std_logic;
        reg: out std_logic_vector (N-1 downto 0));
end johnson;

architecture v1 of johnson is
    signal reg_i: std_logic_vector(N-1 downto 0);
begin

    reg <= reg_i;
    
    process (clock, reset)
    begin
        if( reset = '1') then
            reg_i <= (others=>'0');
        elsif rising_edge(clock) then
            -- using concatenation
            reg_i <= reg_i(N-2 downto 0) & not reg_i(N-1);
        end if;
    end process;
end v1;

architecture v2 of johnson is
    signal reg_i: std_logic_vector(N-1 downto 0);
begin

    reg <= reg_i;
    
    process (clock, reset)
        variable tmp: std_logic;
    begin
        if( reset = '1') then
            reg_i <= (others=>'0');
        elsif rising_edge(clock) then
            -- using shift functions
            tmp := reg_i(N-1); 
            reg_i <= std_logic_vector(shift_left(unsigned(reg_i), 1));
            reg_i(0) <= not tmp;
        end if;
    end process;
end v2;

architecture v3 of johnson is
    signal reg_i: std_logic_vector(N-1 downto 0);
begin

    reg <= reg_i;
    
    process (clock, reset)
    begin
        if( reset = '1') then
            reg_i <= (others=>'0');
        elsif rising_edge(clock) then
            -- using signal attributes
            reg_i <= reg_i(reg_i'left - 1 downto reg_i'right) & not reg_i(reg_i'left);
        end if;
    end process;
end v3;