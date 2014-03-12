library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity pwm_test is
end pwm_test;
 
architecture behavior of pwm_test is 
 
    constant CLOCK_PERIOD : time := 10 ns;
    constant WIDTH : natural := 4;   

    signal clock_run : boolean := true;

    signal clock : std_logic;
    signal reset : std_logic;
    signal duty : unsigned(WIDTH-1 downto 0) := (others => '0');
    signal pwm : std_logic;
begin
 
	-- instantiate the unit under test (uut)
    uut: entity work.pwm(example_2)
    generic map( WIDTH => WIDTH)
    port map (
          clock => clock,
          reset => reset,
          duty => duty,
          pwm => pwm
        );

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
        assert pwm = '0' report "pwm must be '0' after reset";

        reset <= '0';
        duty <= "0011";
        wait for CLOCK_PERIOD * 192;   
        
        duty <= "1100";
        wait for CLOCK_PERIOD * 200;  
        
        clock_run <= false;
        wait;
   end process;

end;
