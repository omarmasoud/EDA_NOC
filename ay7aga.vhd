
library ieee;
use ieee.std_logic_1164.all;
entity ay7aga is
end entity ay7aga;
architecture test of ay7aga is
component Myregister is 

	generic(n:natural:=8);
	port(dataIn: in std_logic_vector(n-1 downto 0);
	clock:in std_logic;
	dataOut:out std_logic_vector(n-1 downto 0);
	clock_en:in std_logic;
	reset:in std_logic);
end component Myregister;
for reg:Myregister use entity work.Myregister(behave);
signal din,dout: std_logic_vector(7 downto 0);
signal en,rst,clk: std_logic;
begin
reg: Myregister generic map (8) port map(din,clk,dout,en,rst);

c1:process is
begin
wait for 20ns;
if clk='1' then
	clk<='0';
else
	clk<='1';
end if;
end process c1;

end architecture test;