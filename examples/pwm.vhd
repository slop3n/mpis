library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity pwm is
    generic ( WIDTH : natural);
    port ( clock : in  std_logic;
      reset : in  std_logic;
      duty : in  unsigned (WIDTH-1 downto 0);
      pwm : out std_logic);
    end pwm;
 
architecture example_1 of pwm is
    type direction is (UP,DOWN);
    
    signal cnt : unsigned(WIDTH-1 downto 0);
    signal pwm_i : std_logic;
    signal dir: direction;
    constant CNT_MAX : unsigned(WIDTH-1 downto 0) := (others=>'1');
    constant CNT_MIN : unsigned(WIDTH-1 downto 0) := (others=>'0');
begin
 
   pwm_i <= '1' when cnt < duty else '0';
   pwm <= pwm_i;
    
   counter: process(clock, reset) begin
       if( reset = '1') then
         cnt <= (others => '0');
         dir <= UP;
       elsif rising_edge(clock) then
          if ( dir = UP ) then
            if( cnt = CNT_MAX ) then
              dir <= DOWN;
            else
              cnt <= cnt + 1;
            end if;
          else
            if( cnt = CNT_MIN ) then
              dir <= UP;
            else
              cnt <= cnt - 1;
            end if;       
          end if;
       end if;
   end process;  
end example_1;

architecture example_2 of pwm is
    type direction is (UP,DOWN);    
    signal cnt : unsigned(WIDTH-1 downto 0);
    signal dir: direction;
    constant CNT_MAX : unsigned(WIDTH-1 downto 0) := (others=>'1');
    constant CNT_MIN : unsigned(WIDTH-1 downto 0) := (others=>'0');
begin

    comparator: process(duty)
    begin
        if (cnt < duty) then
            pwm <= '1';
        else
            pwm <= '0';
        end if;
    end process;
   
   counter: process(clock, reset) begin
       if( reset = '1') then
         cnt <= (others => '0');
         dir <= UP;
       elsif rising_edge(clock) then
          if ( dir = UP ) then
            if( cnt = CNT_MAX ) then
              dir <= DOWN;
            else
              cnt <= cnt + 1;
            end if;
          else
            if( cnt = CNT_MIN ) then
              dir <= UP;
            else
              cnt <= cnt - 1;
            end if;       
          end if;
       end if;
   end process;  
end example_2;