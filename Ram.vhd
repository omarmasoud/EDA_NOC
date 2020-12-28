library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;

entity BlockRam is 
	port(din:in std_logic_vector(7 downto 0);
	dout:out std_logic_vector(7 downto 0);
 	wea,rea:in std_logic;clka,clkb:in std_logic;
	addra,addrb:in std_logic_vector(2 downto 0));
end entity BlockRam;
architecture behave of BlockRam is
type mymemory is array(7 downto 0) of std_logic_vector(7 downto 0);
signal mem :mymemory;
Begin
	wrt:process(clka) is
		begin
		if rising_edge(clka)  then
			if wea='1' then
				mem(conv_integer(addra))<=din;
			else null;
			end if;
		end if;
			
	end process wrt;
	rd:process(clkb) is
		begin
		if rising_edge(clkb)  then
			if rea='1' then
				dout<=mem(conv_integer(addrb));
			else null;
			end if;
		end if;
			
	end process rd;
end architecture behave;