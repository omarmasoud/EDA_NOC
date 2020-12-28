library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;

entity BinaryCounter is
generic(n:natural:=8);
port ( preset,rst,clk: in bit;
	d_in: in std_logic_vector(n-1 downto 0);
 	d_out: out std_logic_vector(n-1 downto 0));
end entity BinaryCounter;
architecture behaviour of BinaryCounter is
signal count:std_logic_vector(n-1 downto 0);
begin
counter:process(clk,rst)
begin
	if rst='1' then
		count<=(others=>'0');
	elsif preset='1' then
		count<=d_in;
	elsif rising_edge(clk)then
		
count<=count+1;
	end if;
	
end process counter;
d_out<=count;
end architecture behaviour;
