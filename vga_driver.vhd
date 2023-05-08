library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;

-- entity declaration
entity vga_driver is
  Port (vsync : out std_logic;
        hsync : out std_logic;
        clk_100mhz : in std_logic;
        red : out std_logic_vector(3 downto 0);
        blue : out std_logic_vector(3 downto 0);
        green : out std_logic_vector(3 downto 0));
end vga_driver;



architecture Behavioral of vga_driver is
    signal reset, locked : std_logic;
    signal clk_25mhz, hrst : std_logic;
    signal vclock, vrst    : std_logic;
    signal hcounter : std_logic_vector(9 downto 0);
    signal vcounter : std_logic_vector(9 downto 0);
    signal h_000, h_640, h_704, h_800 : std_logic;
    signal v_000, v_480, v_523, v_525 : std_logic;
    signal h_vs, v_vs, vs : std_logic;
    signal RAM_out_bus : std_logic_vector(7 downto 0);
    

----------clk ip component----------
component clk_wiz_0
    port(clk_out1 : out    std_logic;
         reset    : in     std_logic;
         locked   : out    std_logic;
         clk_in1  : in     std_logic);
end component;
-------------------------------------
----------counter component----------
component counter_10bit is
  Port (q : out std_logic_vector(9 downto 0);
        clk_25mhz : in std_logic;
        rst : in std_logic);
end component;
-----------------------------------
----------------hlogic-------------
component hlogic is
  Port (hcounter : in std_logic_vector(9 downto 0);
        h_000 : inout std_logic;
        h_640 : inout std_logic;
        h_704 : inout std_logic;
        h_800 : inout std_logic);
end component;
-------------------------------------
----------------hlogic---------------
component vlogic
  Port (vcounter : in std_logic_vector(9 downto 0);
        v_000 : inout std_logic;
        v_480 : inout std_logic;
        v_523 : inout std_logic;
        v_525 : inout std_logic);
end component;
-------------------------------------
----------------VRAM---------------
component VRAM is
    port(--inouts
         RAM_addrs : in std_logic_vector(19 downto 0);
         RAM_out_bus : out std_logic_vector(7 downto 0));
end component;
-------------------------------------
begin

clock_src_25mhz : clk_wiz_0 port map ( -- Clock out ports  
                                       clk_out1 => clk_25mhz,
                                      -- Status and control signals                
                                       reset => reset,
                                       locked => locked,
                                       -- Clock in ports
                                       clk_in1 => clk_100mhz);
                                       
H_counter : counter_10bit port map (clk_25mhz => clk_25mhz,
                                    rst => h_800,
                                    q => hcounter);
                                    
H_logic : hlogic port map(hcounter => hcounter,
                          h_000 => h_000,
                          h_640 => h_640,
                          h_704 => h_704,
                          h_800 => h_800);
                          
V_counter : counter_10bit port map (clk_25mhz => h_800,
                                    rst => v_525,
                                    q => vcounter);
 
V_logic : vlogic port map(vcounter => vcounter,
                          v_000 => v_000,
                          v_480 => v_480,
                          v_523 => v_523,
                          v_525 => v_525);
                      
RAM : VRAM port map(RAM_addrs(9 downto 0) => hcounter,
                    RAM_addrs(19 downto 10) => vcounter,
                    RAM_out_bus => RAM_out_bus);


process(h_000, h_704)
begin
if (h_000 = '1') then
    hsync <= '1';
elsif (h_704 = '1') then
    hsync <= '0';
end if;
end process;

process(v_000, v_523)
begin
if (v_000 = '1') then
    vsync <= '1';
elsif (v_523 = '1') then
    vsync <= '0';
end if;
end process;


--process(hcounter, vcounter)
--begin
--if (to_integer(unsigned(hcounter)) > 703 and to_integer(unsigned(hcounter)) < 799) then
--    hsync <= '0';
--elsif (to_integer(unsigned(hcounter)) = 799) then
--    hrst <= '1';
--else
--    hsync <= '1';
--    hrst <= '0';
--end if;
--if (to_integer(unsigned(vcounter)) > 522 and to_integer(unsigned(vcounter)) < 525) then
--    vsync <= '0';
--elsif (to_integer(unsigned(vcounter)) = 525) then
--    vrst <= '1';
--else
--    vsync <= '1';
--    vrst <= '0';
--end if;


process(hcounter, vcounter)
begin
if (to_integer(unsigned(hcounter)) > 48 and to_integer(unsigned(hcounter)) < 651 and
    to_integer(unsigned(vcounter)) > 18 and to_integer(unsigned(vcounter)) < 498) then
    red(2 downto 0) <= RAM_out_bus(7 downto 5);
    blue(1 downto 0) <= RAM_out_bus(1 downto 0);
    green(2 downto 0) <= RAM_out_bus(4 downto 2);
else
    red(2 downto 0) <= "000";
    blue(1 downto 0) <= "00";
    green(2 downto 0) <= "000";
end if;
end process;


--    red <= "0000";
--    blue <= "0000";
--    green <= "0000";
blue(3 downto 2) <= "00";
green(3) <= '0';
red(3) <= '0';
reset <= '0';
vclock <= clk_25mhz and hrst;
end Behavioral;


