library ieee;
use ieee.std_logic_1164.all;
entity Myregister is 

	generic(n:natural:=8);
	port(dataIn: in std_logic_vector(n-1 downto 0);
	clock:in std_logic;
	dataOut:out std_logic_vector(n-1 downto 0);
	clock_en:in std_logic;
	reset:in std_logic);
end entity Myregister;
architecture reg of Myregister is
signal temp:std_logic_vector(n-1 downto 0);
begin
p1:process(clock,reset)
	begin
	if reset='1' then
	temp<=(others=>'0');
	elsif( rising_edge(clock)and clock_en='1' )then
	temp<=dataIn;
	end if; 
end process p1;
dataOut<=temp;
end architecture reg;
