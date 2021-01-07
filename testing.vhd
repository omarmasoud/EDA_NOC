
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;

entity tester is
end entity tester;

architecture behave of tester is

component Router is 
port(datai1,datai2,datai3,datai4:in std_logic_vector(7 downto 0);
	datao1,datao2,datao3,datao4:out std_logic_vector(7 downto 0);
	wr1,wr2,wr3,wr4,rst,wclk,rclk:in std_logic);
end component Router;

signal di1,di2,di3,di4,do1,do2,do3,do4:std_logic_vector(7 downto 0);
signal w1,w2,w3,w4:std_logic:='1';
signal rst:std_logic;
signal wclk:std_logic:='0';
signal rclk:std_logic:='1';

for rout:Router use entity work.Router(mixed);
begin
rout:Router port map(di1,di2,di3,di4,do1,do2,do3,do4,w1,w2,w3,w4,rst,wclk,rclk);

c1:process is
begin
wait for 2 ns;
if rclk='1' then
	rclk<='0';
else
	rclk<='1';
end if;
end process c1;

c2:process is
begin
wait for 2 ns;
if wclk='1' then
	wclk<='0';
else
	wclk<='1';
end if;
end process c2;

p1:process is
begin
--rst<='1';
--wait for  2.286ns;
rst<='0';
di1<="00011100";
di2<="11100001";
di3<="10000111";
di4<="10000110";
w1<='1';
w2<='1';
w3<='1';
w4<='1';

wait for 4 ns;
w1<='0';
w2<='0';
w3<='1';
w4<='1';
di1<="10100111";
di2<="10101100";
di3<="11111101";
di4<="11111111";
wait for  3 ns;
--di1<="10100100";
--di2<="10101101";
--di3<="11111111";
--di4<="00000110";

wait for  5 ns;

ASSERT  do4="10000111"
REPORT "Problem with output from port 4"
SEVERITY error;
wait for 4 ns;

ASSERT  do4="11111111"
REPORT "Problem with write request 4"
SEVERITY error;

wait for 4 ns;


ASSERT do1="00011100" REPORT "Problem with output from port 1 (First FIFO)"
SEVERITY error;

wait for 4 ns;
wait;
end process p1;

end architecture behave;