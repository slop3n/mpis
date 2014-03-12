library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mpis.all;
 
entity bcd_counter_test is
end bcd_counter_test;
 
architecture behavior of bcd_counter_test is 

    constant CLOCK_PERIOD : time := 10 ns;
    constant WIDTH : integer := 4;   

    signal clock_run : boolean := true;

    signal clock : std_logic;
    signal reset : std_logic;
    signal q : unsigned(3 downto 0);

begin

    uut: entity work.bcd_counter(with_variable) 
        port map (
            clock => clock,
            reset => reset,
            q => q
        );

    clock_process :process
    begin
        if clock_run then
            clock <= '0';
            wait for CLOCK_PERIOD/2;
            clock <= '1';
            wait for CLOCK_PERIOD/2;
        else
            wait;
        end if;
    end process;
 
    stim_proc: process
    begin		
        reset <= '1';
        wait until falling_edge(clock);
        assert q = to_unsigned(0, WIDTH) report "q must be '0'";

        -- test up counting from 1 to 9
        reset <= '0';
        for i in 1 to 9 loop
            wait until falling_edge(clock);
            assert are_equal(q,i) report "q must be " & natural'image(i);  
        end loop;

        -- check counter overflow
        wait until falling_edge(clock);
        assert q = to_unsigned(0, WIDTH) report "q must be 0";  

        for i in 1 to 9 loop
            wait until falling_edge(clock);
            assert are_equal(q,i) report "q must be " & natural'image(i);  
        end loop;
        
        clock_run <= false;
        wait;
    end process;
end;
