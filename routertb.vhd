
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
entity routertest is
end entity routertest;
architecture behave of routertest is
component Router is 
port(datai1,datai2,datai3,datai4:in std_logic_vector(7 downto 0);
	datao1,datao2,datao3,datao4:out std_logic_vector(7 downto 0);
	wr1,wr2,wr3,wr4,rst,wclk,rclk:in std_logic);
end component Router;
signal di1,di2,di3,di4,do1,do2,do3,do4:std_logic_vector(7 downto 0);
signal w1,w2,w3,w4,rst,wclk,rclk:std_logic;
for rout:Router use entity work.Router(behave);
begin
rout:Router port map(di1,di2,di3,di4,do1,do2,do3,do4,w1,w2,w3,w4,rst,wclk,rclk);
di1<="11000011";
di2<="00100000";
di3<="10100010";
di4<="01010001";
w1<='1';
w2<='1';
w3<='1';
w4<='1';
c1:process is
begin
wait for 20ns;
if rclk='1' then
	rclk<='0';
else
	rclk<='1';
end if;
end process c1;
c2:process is
begin
wait for 20ns;
if wclk='1' then
	wclk<='0';
else
	wclk<='1';
end if;
end process c2;
end architecture behave;