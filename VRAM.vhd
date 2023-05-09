--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use ieee.NUMERIC_STD.all;

--entity VRAM is
--    port(--inouts
--         RAM_addrs : in std_logic_vector(19 downto 0);
--         RAM_out_bus : out std_logic_vector(7 downto 0));
--end entity;
  
  

--architecture Behavioral of VRAM  is
--type RAM_array is array (0 to 1048576) of std_logic_vector(7 downto 0);
--signal RAM_data : RAM_array := (others => b"00011100");
                                

--begin
--RAM_out_bus <= RAM_data(to_integer(unsigned(RAM_addrs)));
--end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;

entity VRAM is
    port(
         RAM_addrs : in std_logic_vector(19 downto 0);
         RAM_out_bus : out std_logic_vector(7 downto 0));
end entity;
  
architecture Behavioral of VRAM is
    type RAM_array is array (0 to 1048575) of std_logic_vector(7 downto 0);
    signal RAM_data : RAM_array;
begin
    -- Initialize RAM_data with random values
    process
    begin
        for i in RAM_data'range loop
            RAM_data(i) <= std_logic_vector(to_unsigned(i,8));
        end loop;
        wait;
    end process;

    RAM_out_bus <= RAM_data(to_integer(unsigned(RAM_addrs)));
end Behavioral;

