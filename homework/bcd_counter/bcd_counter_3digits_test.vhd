library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mpis.all;
 
entity bcd_counter_3digits_test is
end bcd_counter_3digits_test;
 
architecture behavioral of bcd_counter_3digits_test is
   constant CLOCK_PERIOD : time := 10 ns; 
   signal clock_run : boolean := true;
     
   signal clock, reset : std_logic;
   signal bcd0, bcd1, bcd2 : unsigned(3 downto 0);
 
begin
    -- instantiate the unit under test (uut)
    uut: entity work.bcd_counter_3digits
    port map ( clock => clock, 
        reset => reset,     
        bcd0 => bcd0, 
        bcd1 => bcd1, 
        bcd2 => bcd2 );
 
   -- clock process
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
  
   -- stimulus process
   stim_proc: process
   begin       
        reset <= '1';
        wait until falling_edge(clock);
        assert are_equal(bcd0,0) report "bcd0 " & format_diff(0, to_integer(bcd0));
        assert are_equal(bcd1,0) report "bcd1 " & format_diff(0, to_integer(bcd1));
        assert are_equal(bcd2,0) report "bcd2 " & format_diff(0, to_integer(bcd2));
                
        for i2 in 0 to 9 loop
            for i1 in 0 to 9 loop
                for i0 in 0 to 9 loop
                    wait until falling_edge(clock);
                    reset <= '0';
                    assert are_equal(bcd0,i0) report "bcd0 " & format_diff(i0, to_integer(bcd0));
                    assert are_equal(bcd1,i1) report "bcd1 " & format_diff(i1, to_integer(bcd1));
                    assert are_equal(bcd2,i2) report "bcd2 " & format_diff(i2, to_integer(bcd2));
                end loop;
            end loop;        
        end loop;        
         
        -- stop the clock
        clock_run <= false;
        wait;
    end process;
end;