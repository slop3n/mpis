library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_register is
    generic(N : natural);
    port( clock: in  std_logic;
        reset: in  std_logic;
        mode: in std_logic_vector(0 to 1);
        data_in: in unsigned(N-1 downto 0);
        data_out: out unsigned(N-1 downto 0));
end shift_register;

architecture v1 of shift_register is
begin
    -- TODO
end v1;