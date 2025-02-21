
library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;

entity ramtest is
end entity ramtest;
architecture behave of ramtest is
component BlockRam is 
	port(din:in std_logic_vector(7 downto 0);
	dout:out std_logic_vector(7 downto 0);
 	wea,rea:in std_logic;clka,clkb:in std_logic;
	addra,addrb:in std_logic_vector(2 downto 0));
end component BlockRam;
for bc: BlockRam use entity work.BlockRam(behave);
signal din,dout:std_logic_vector(7 downto 0);
signal addra,addrb:std_logic_vector(2 downto 0);
signal clka,clkb:std_logic;
signal wea,rea:std_logic;
begin
bc:BlockRam port map(din,dout,wea,rea,clka,clkb,addra,addrb);
c1:process is
begin
wait for 20ns;
if clka='1' then
	clka<='0';
else
	clka<='1';
end if;
end process c1;
c2:process is
begin
wait for 20ns;
if clkb='1' then
	clkb<='0';
else
	clkb<='1';
end if;
end process c2;

end architecture behave;