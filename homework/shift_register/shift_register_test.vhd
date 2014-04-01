library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_register_test is
end shift_register_test;
 
architecture test1 of shift_register_test is
 
    constant CLOCK_PERIOD : time := 10 ns;
    constant WIDTH : integer := 8;  
 
    signal clock_run : boolean := true;
    
    signal clock : std_logic;
    signal reset : std_logic;
    signal data_in, data_out : unsigned( WIDTH-1 downto 0 );
    signal mode: std_logic_vector(0 to 1);
begin
 
	-- instantiate the unit under test (uut)
   uut: entity work.shift_register 
      generic map (N => WIDTH)
      port map (
          clock => clock,
          reset => reset,
          mode => mode,
          data_in => data_in,
          data_out => data_out
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
        variable temp: unsigned(data_out'range); 
    begin      
        reset <= '1';
        data_in <=  (others => '1');
        mode <= "00";
        wait until falling_edge(clock);

        reset <= '0';
        wait until falling_edge(clock);
        assert data_out = to_unsigned(0,WIDTH) report "test 1. data_out=0";

        mode <= "11"; -- test 2. load
        wait until falling_edge(clock);
        assert data_out = data_in report "test 2. mode=load";

        mode <= "01"; -- test 3. shift right
        for i in WIDTH downto 1 loop
            temp := data_out;
            wait until falling_edge(clock);            
            assert temp(WIDTH-1 downto 1) = data_out(WIDTH-2 downto 0) 
                report "test 3. Data is not shifted. i=" & integer'image(i);
            assert data_out(WIDTH-1) = '0' report "test 3. The MSB is not '0' i=" & integer'image(i);            
        end loop;
        
        mode <= "11"; -- test 4. load '0' in LSB
        data_in <=  (0=>'1', others => '0');
        wait until falling_edge(clock);
        assert data_out = data_in report "test 4.";

        mode <= "00"; -- test 5. hold
        wait until falling_edge(clock);
        assert data_out = data_in report "test 5-1.";
        wait until falling_edge(clock);
        assert data_out = data_in report "test 5-2.";
        wait until falling_edge(clock);
        assert data_out = data_in report "test 5-3.";
        
        mode <= "10"; -- test 6. shift left
        for i in WIDTH downto 1 loop
            temp := data_out;
            wait until falling_edge(clock);            
            assert temp(WIDTH-2 downto 0) = data_out(WIDTH-1 downto 1) 
                report "test 6. Data is not shifted. i=" & integer'image(i);
            assert data_out(0) = '0' report "test 6. The LSB is not '0' i=" & integer'image(i);            
        end loop;

        clock_run <= false;

        wait;
    end process;

end;
