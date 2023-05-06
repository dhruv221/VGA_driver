library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;


entity counter_10bit is
  Port (q : out std_logic_vector(9 downto 0);
        clk_25mhz : in std_logic;
        rst : in std_logic);
end counter_10bit;


architecture Behavioral of counter_10bit is
signal val : std_logic_vector(9 downto 0);
begin
process(clk_25mhz)
begin
    if (rst = '1') then
        val <= "0000000000";
    elsif (rising_edge(clk_25mhz)) then
        val <= val + '1';
    end if;
end process;
q <= val;
end Behavioral;
