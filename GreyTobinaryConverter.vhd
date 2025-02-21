

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
entity graytobinary is
generic(n:natural:=3);
port(grayin:in std_logic_vector(n-1 downto 0);
	grayout:out std_logic_vector(n-1 downto 0));
end entity graytobinary;
architecture behave of graytobinary is
signal count:std_logic_vector(n-1 downto 0);
begin

conv:process(grayin) is
variable counter:std_logic;
begin
--counter:=grayin;
count(n-1)<=grayin(n-1);
for i in(n-2)downto 0 loop
counter:=grayin(n-1);
	for j in (n-2) downto i loop
	counter:=counter xor grayin(j);
	end loop;
count(i)<=counter;
end loop;
end process conv;
grayout<=count;

end architecture behave;