library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity hlogic is
  Port (hcounter : in std_logic_vector(9 downto 0);
        h_000 : inout std_logic;
        h_640 : inout std_logic;
        h_704 : inout std_logic; --sync
        h_800 : inout std_logic);
end hlogic;

architecture Behavioral of hlogic is
    
begin

h_000 <= not hcounter(9) and not hcounter(8) and not hcounter(7) and not(hcounter(6)) 
         and not hcounter(5) and not hcounter(4) and not hcounter(3) and not hcounter(2) 
         and not hcounter(1) and not hcounter(0);
         
h_640 <= hcounter(9) and not hcounter(8) and hcounter(7) and not hcounter(6) 
         and not hcounter(5) and not hcounter(4) and not hcounter(3) and not hcounter(2) 
         and not hcounter(1) and not hcounter(0);
         
h_704 <= hcounter(9) and not(hcounter(8)) and hcounter(7) and (hcounter(6)) 
         and not hcounter(5) and not hcounter(4) and not hcounter(3) and not hcounter(2) 
         and not hcounter(1) and not hcounter(0);

h_800 <= hcounter(9) and hcounter(8) and not hcounter(7) and not(hcounter(6)) 
         and hcounter(5) and not hcounter(4) and not hcounter(3) and not hcounter(2) 
         and not hcounter(1) and not hcounter(0);

--process(hcounter)
--begin
--if (to_integer(unsigned(hcounter)) = 0) then
--    h_000 <= '1';
--elsif (to_integer(unsigned(hcounter)) = 640) then
--    h_639 <= '1';
--elsif (to_integer(unsigned(hcounter)) = 656) then
--    h_655 <= '1';
--elsif (to_integer(unsigned(hcounter)) = 752) then
--    h_751 <= '1';
--elsif (to_integer(unsigned(hcounter)) = 800) then
--    h_800 <= '1';
--end if;
--end process;

end Behavioral;
