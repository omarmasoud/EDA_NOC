
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
entity Router2 is 
port(datai1,datai2,datai3,datai4:in std_logic_vector(7 downto 0);
	datao1,datao2,datao3,datao4:out std_logic_vector(7 downto 0);
	wr1,wr2,wr3,wr4,rst,wclk,rclk:in std_logic);
end entity Router2;
architecture mixed of Router2 is 
component Myregister is 
	generic(n:natural:=8);
	port(dataIn: in std_logic_vector(n-1 downto 0);
	clock:in std_logic;
	dataOut:out std_logic_vector(n-1 downto 0);
	clock_en:in std_logic;
	reset:in std_logic);
end component Myregister;
component RoundRobinScheduler is 
	port(
	reset:in std_logic;
	clock:in std_logic;
	din1,din2,din3,din4:in std_logic_vector( 7 downto 0);
	dout:out std_logic_vector( 7 downto 0));
end component RoundRobinScheduler;
component fifo is 
port(reset:in std_logic;rclk,wclk:in std_logic;rreq,wreq:in std_logic;
	datain:in std_logic_vector(7 downto 0);dataout:out std_logic_vector(7 downto 0);
	empty,full:out std_logic);
end component fifo;
component bit8demux is 
	port(d_in: in std_logic_vector(7 downto 0);
	d_out1:out std_logic_vector (7 downto 0);
	d_out2:out std_logic_vector (7 downto 0);
	d_out3:out std_logic_vector (7 downto 0);
	d_out4:out std_logic_vector (7 downto 0);
	sel:in std_logic_vector(1 downto 0);
	En: in std_logic);
end component bit8demux;
type arr16 is array (15 downto 0) of std_logic_vector(7 downto 0);
signal rrsync: std_logic_vector(3 downto 0);
for all:Myregister use entity work.Myregister(reg);
for all:bit8demux use entity work.bit8demux(behaviour);
for all: fifo use entity work.fifo(Structural);
for all:RoundRobinScheduler use entity work.RoundRobinScheduler(moorefsm);
begin

gen_fifo: for i in 15 downto 0 generate

 fifo  
port map(rst,rclk,wclk,rrsync);
 end generate gen_fifo;

end architecture mixed;