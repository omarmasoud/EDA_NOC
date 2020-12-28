

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;

entity mycounter is 
end entity mycounter;
architecture behave of mycounter is
component GreyCounter is
generic(n:natural:=3);
port ( en,rst,clk: in bit;
 	d_out: out std_logic_vector(n-1 downto 0));
end component GreyCounter;
component graytobinary is
generic(n:natural:=3);
port(grayin:in std_logic_vector(n-1 downto 0);
	grayout:out std_logic_vector(n-1 downto 0));
end component graytobinary;
signal clock:bit:='0';
signal en:bit:='1';
signal rst:bit:='0';
signal output,output2:std_logic_vector(2 downto 0):=(others=>'0');
for gc:GreyCounter use entity work.GreyCounter(behaviour);
for convr: graytobinary use entity work.graytobinary(behave);
begin
gc:GreyCounter generic map(3) port map(en,rst,clock,output);
convr:graytobinary generic map(3) port map(output,output2);

clk:process 
begin
wait for 10ns;
if clock='1' then
clock<='0';
else clock<='1';
end if;
end process clk;
end architecture behave;