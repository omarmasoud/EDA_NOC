

library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
entity fifotest  is
end entity fifotest;
architecture testing of fifotest is
component fifo is 
port(reset:in std_logic;rclk,wclk:in std_logic;rreq,wreq:in std_logic;
	datain:in std_logic_vector(7 downto 0);dataout:out std_logic_vector(7 downto 0);
	empty,full:out std_logic);
end component fifo;
for myfifo:fifo use entity work.fifo(Structural);
signal rst,rclk,wclk,rreq,wreq:std_logic:='0';
signal em,fu:std_logic;
signal di,do:std_logic_vector(7 downto 0);
begin
myfifo:fifo port map (rst,rclk,wclk,rreq,wreq,di,do,em,fu);
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
end architecture testing;
