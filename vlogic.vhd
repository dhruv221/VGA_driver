library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity vlogic is
  Port (vcounter : in std_logic_vector(9 downto 0);
        v_000 : inout std_logic;
        v_480 : inout std_logic;
        v_523 : inout std_logic; --sync
        v_525 : inout std_logic);
end vlogic;

architecture Behavioral of vlogic is

begin
v_000 <= not vcounter(9) and not vcounter(8) and not vcounter(7) and not vcounter(6) 
         and not vcounter(5) and not vcounter(4) and not vcounter(3) and not vcounter(2) 
         and not vcounter(1) and not vcounter(0);
         
v_480 <= not vcounter(9) and vcounter(8) and vcounter(7) and vcounter(6) 
         and vcounter(5) and not vcounter(4) and not vcounter(3) and not vcounter(2) 
         and not vcounter(1) and not vcounter(0);
         
v_523 <= vcounter(9) and not vcounter(8) and not vcounter(7) and not vcounter(6)
         and not vcounter(5) and not vcounter(4) and vcounter(3) and not vcounter(2) 
         and vcounter(1) and vcounter(0);
         
v_525 <= vcounter(9) and not vcounter(8) and not vcounter(7) and not vcounter(6)
         and not vcounter(5) and not vcounter(4) and vcounter(3) and vcounter(2) 
         and not vcounter(1) and vcounter(0);

--process(vcounter)
--begin
--if (to_integer(unsigned(vcounter)) = 0) then
--    v_000 <= '1';
--end if;
--if (to_integer(unsigned(vcounter)) = 480) then
--    v_479 <= '1';
--end if;
--if (to_integer(unsigned(vcounter)) = 490) then
--    v_489 <= '1';
--end if;
--if (to_integer(unsigned(vcounter)) = 492) then
--    v_491 <= '1';
--end if;
--if (to_integer(unsigned(vcounter)) = 525) then
--    v_525 <= '1';
--end if;
--end process;

end Behavioral;
