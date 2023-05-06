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
    signal h_000, h_703, h_800, h_639 : std_logic;
    signal v_000, v_522, v_525, v_479 : std_logic;
    signal h_vs, v_vs, vs : std_logic;
    

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
-------------------------------------
------------------hlogic---------------
--component hlogic is
--  Port (hcounter : in std_logic_vector(9 downto 0);
--        h_703 : inout std_logic;
--        h_800 : inout std_logic;
--        h_000 : inout std_logic;
--        h_639 : inout std_logic;
--        hsync : out std_logic;
--        rst   : out std_logic);
--end component;
---------------------------------------
------------------hlogic---------------
--component vlogic
--  Port (vcounter : in std_logic_vector(9 downto 0);
--        v_000 : inout std_logic;
--        v_522 : inout std_logic;
--        v_525 : inout std_logic;
--        v_479 : inout std_logic;
--        vsync : out std_logic;
--        rst   : out std_logic);
--end component;
---------------------------------------
begin

clock_src_25mhz : clk_wiz_0 port map ( -- Clock out ports  
                                       clk_out1 => clk_25mhz,
                                      -- Status and control signals                
                                       reset => reset,
                                       locked => locked,
                                       -- Clock in ports
                                       clk_in1 => clk_100mhz);
                                       
H_counter : counter_10bit port map (clk_25mhz => clk_25mhz,
                                    rst => hrst,
                                    q => hcounter);
                                    
--H_logic : hlogic port map(hcounter => hcounter,
--                          h_703 => h_703,
--                          h_800 => h_800,
--                          h_000 => h_000,
--                          h_639 => h_639,
--                          hsync => hsync,
--                          rst   => hrst);
                          
V_counter : counter_10bit port map (clk_25mhz => hrst,
                                    rst => vrst,
                                    q => vcounter);
 
--V_logic : vlogic port map(vcounter => vcounter,
--                          v_525 => v_525,
--                          v_522 => v_522,
--                          v_000 => v_000,
--                          v_479 => v_479,
--                          vsync => vsync,
--                          rst   => vrst);



process(hcounter, vcounter)
begin
if (to_integer(unsigned(hcounter)) > 703 and to_integer(unsigned(hcounter)) < 799) then
    hsync <= '0';
elsif (to_integer(unsigned(hcounter)) = 799) then
    hrst <= '1';
else
    hsync <= '1';
    hrst <= '0';
end if;
if (to_integer(unsigned(vcounter)) > 522 and to_integer(unsigned(vcounter)) < 525) then
    vsync <= '0';
elsif (to_integer(unsigned(vcounter)) = 525) then
    vrst <= '1';
else
    vsync <= '1';
    vrst <= '0';
end if;



if (to_integer(unsigned(hcounter)) < 639 and to_integer(unsigned(vcounter)) < 479) then
    red <= "1100";
    blue <= "1111";
    green <= "0000";
else
    red <= "0000";
    blue <= "0000";
    green <= "0000";
end if;
end process;


reset <= '0';
vclock <= clk_25mhz and hrst;
end Behavioral;


