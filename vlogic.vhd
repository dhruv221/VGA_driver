library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity vlogic is
  Port (vcounter : in std_logic_vector(9 downto 0);
        v_000 : inout std_logic;
        v_479 : inout std_logic;
        v_522 : inout std_logic;
        v_525 : inout std_logic);
end vlogic;

architecture Behavioral of vlogic is

begin
v_000 <= not vcounter(9) and not vcounter(8) and not vcounter(7) and not vcounter(6) 
         and not vcounter(5) and not vcounter(4) and not vcounter(3) and not vcounter(2) 
         and not vcounter(1) and not vcounter(0);
         
v_479 <= not vcounter(9) and vcounter(8) and vcounter(7) and vcounter(6) 
         and not vcounter(5) and vcounter(4) and vcounter(3) and vcounter(2) 
         and vcounter(1) and vcounter(0);
         
v_522 <= vcounter(9) and not vcounter(8) and not vcounter(7) and not vcounter(6)
         and not vcounter(5) and not vcounter(4) and vcounter(3) and not vcounter(2) 
         and vcounter(1) and not vcounter(0);
         
v_525 <= vcounter(9) and not vcounter(8) and not vcounter(7) and not vcounter(6)
         and not vcounter(5) and not vcounter(4) and vcounter(3) and vcounter(2) 
         and not vcounter(1) and vcounter(0);

end Behavioral;
