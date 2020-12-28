
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
entity Router is 
port(datai1,datai2,datai3,datai4:in std_logic_vector(7 downto 0);
	datao1,datao2,datao3,datao4:out std_logic_vector(7 downto 0);
	wr1,wr2,wr3,wr4,rst,wclk,rclk:in std_logic);
end entity Router;
architecture behave of Router is 
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
for all:Myregister use entity work.Myregister(reg);
for all:bit8demux use entity work.bit8demux(behaviour);
for all: fifo use entity work.fifo(behave);
for all:RoundRobinScheduler use entity work.RoundRobinScheduler(behave);
signal buffo1,buffo2,buffo3,buffo4:std_logic_vector(7 downto 0);
signal dem1o1,dem1o2,dem1o3,dem1o4:std_logic_vector(7 downto 0);
signal dem2o1,dem2o2,dem2o3,dem2o4:std_logic_vector(7 downto 0);
signal dem3o1,dem3o2,dem3o3,dem3o4:std_logic_vector(7 downto 0);
signal dem4o1,dem4o2,dem4o3,dem4o4:std_logic_vector(7 downto 0);
begin
--input buffers
buff1: Myregister generic map(8) port map(datai1,wclk,buffo1,wr1,rst);
buff2: Myregister generic map(8) port map(datai1,wclk,buffo2,wr1,rst);
buff3: Myregister generic map(8) port map(datai1,wclk,buffo3,wr1,rst);
buff4: Myregister generic map(8) port map(datai1,wclk,buffo4,wr1,rst);
--switch fabrics;
dem1:bit8demux port map(buffo1,dem1o1,dem1o2,dem1o3,dem1o4,buffo1(1 downto 0),wr1);
dem2:bit8demux port map(buffo2,dem2o1,dem2o2,dem2o3,dem2o4,buffo2(1 downto 0),wr1);
dem3:bit8demux port map(buffo3,dem3o1,dem3o2,dem3o3,dem3o4,buffo4(1 downto 0),wr1);
dem4:bit8demux port map(buffo4,dem4o1,dem4o2,dem4o3,dem4o4,buffo4(1 downto 0),wr1);
--fifos for output queueing
fifo1:fifo port map(rst,rclk,wclk);
--round robin schedulers for synchronizing output buffers with queues
--output buffers
end architecture behave;