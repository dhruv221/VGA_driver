library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;


entity hlogic is
  Port (hcounter : in std_logic_vector(9 downto 0);
        h_703 : inout std_logic;
        h_800 : inout std_logic;
        h_000 : inout std_logic;
        h_639 : inout std_logic;
        hsync : out std_logic;
        rst   : out std_logic);
end hlogic;

architecture Behavioral of hlogic is
    
begin
h_703 <= hcounter(9) and not(hcounter(8)) and hcounter(7) and not(hcounter(6)) 
         and hcounter(5) and hcounter(4) and hcounter(3) and hcounter(2) 
         and hcounter(1) and hcounter(0);

h_800 <= hcounter(9) and hcounter(8) and not hcounter(7) and not(hcounter(6)) 
         and hcounter(5) and not hcounter(4) and not hcounter(3) and not hcounter(2) 
         and not hcounter(1) and not hcounter(0);
         
h_000 <= not hcounter(9) and not hcounter(8) and not hcounter(7) and not(hcounter(6)) 
         and not hcounter(5) and not hcounter(4) and not hcounter(3) and not hcounter(2) 
         and not hcounter(1) and not hcounter(0);
         
h_639 <= hcounter(9) and not hcounter(8) and not hcounter(7) and hcounter(6) 
         and hcounter(5) and hcounter(4) and hcounter(3) and hcounter(2) 
         and hcounter(1) and hcounter(0);

process(h_703, h_800)
begin
if (h_703 = '1') then
    hsync <= '0';
elsif (h_800 = '1') then
    hsync <= '1';
    rst <= '1';
elsif (h_000 = '1') then
    hsync <= '1';
    rst <= '0';
end if;
end process;

end Behavioral;