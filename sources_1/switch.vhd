
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.complex.all;


entity switch is
  Port ( 
    in1,in2 : in complex_x;
    inv : in std_logic;
    out1, out2 : out complex_x
    );
end switch;

architecture Behavioral of switch is

begin
    out1 <= in2 when(inv='1') else in1;
    out2 <= in1 when(inv='1') else in2;


end Behavioral;
