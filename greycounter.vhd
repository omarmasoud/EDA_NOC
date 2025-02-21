library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
entity GreyCounter is
generic(n:natural:=3);
port ( en,rst:in std_logic;clk: in std_logic;
 	d_out: out std_logic_vector(n-1 downto 0));
end entity GreyCounter;
architecture behaviour of GreyCounter is
signal count:std_logic_vector(n-1 downto 0):=(others=>'0');
--signal greycount:std_logic_vector(n-1 downto 0);
begin
counter:process(clk,rst)
begin
	if rst='1' then
		count<=(others=>'0');
	elsif rising_edge(clk) then
	if  en='1'then
	count<=count+1;
	else null;
	end if;
	else null;
	end if;
end process counter;
grey:process(count)is
begin
d_out(n-1)<=count(n-1);
for i in n-2 downto 0 loop
d_out(i)<=count(i)xor count(i+1);
end loop;
end process grey;
end architecture behaviour;