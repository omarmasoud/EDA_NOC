library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity testing is
end entity testing;
architecture behave of testing is
component GreyCounter is
generic(n:natural:=8);
port ( en,rst,clk: in std_logic;
 	d_out: out std_logic_vector(n-1 downto 0));
end component GreyCounter;
signal clock:std_logic:='0';
signal en:std_logic:='0';
signal rst:std_logic:='0';
signal output:std_logic_vector(7 downto 0);
for cnt: GreyCounter use entity work.GreyCounter(behaviour);
begin
cnt:GreyCounter generic map(8) port map(en,rst,clock,output);
clk:process 
begin
wait for 10ns;
if clock='1' then
clock<='0';
else clock<='1';
end if;
end process clk;
pro:process is
begin
wait for 100ns;
rst<='1';
end process pro;
end architecture behave;
