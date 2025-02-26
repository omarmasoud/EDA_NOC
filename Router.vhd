library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
entity Router is 
port(datai1,datai2,datai3,datai4:in std_logic_vector(7 downto 0);
	datao1,datao2,datao3,datao4:out std_logic_vector(7 downto 0);
	wr1,wr2,wr3,wr4,rst,wclk,rclk:in std_logic);
end entity Router;
architecture mixed of Router is 
component bit8register is 
	generic(n:natural:=8);
	port(dataIn: in std_logic_vector(n-1 downto 0);
	clock:in std_logic;
	dataOut:out std_logic_vector(n-1 downto 0);
	clock_en:in std_logic;
	reset:in std_logic);
end component bit8register;
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
for all:bit8register use entity work.bit8register(behave);
for all:bit8demux use entity work.bit8demux(behaviour);
for all: fifo use entity work.fifo(Structural);
for all:RoundRobinScheduler use entity work.RoundRobinScheduler(moorefsm);
--signals for buffers outputs indexed
signal buffo1,buffo2,buffo3,buffo4:std_logic_vector(7 downto 0);
--signals for switch fabric outputs indexed by output and switch number
signal dem1o1,dem1o2,dem1o3,dem1o4:std_logic_vector(7 downto 0);
signal dem2o1,dem2o2,dem2o3,dem2o4:std_logic_vector(7 downto 0);
signal dem3o1,dem3o2,dem3o3,dem3o4:std_logic_vector(7 downto 0);
signal dem4o1,dem4o2,dem4o3,dem4o4:std_logic_vector(7 downto 0);
--fifo empty flags
signal em1,em2,em3,em4,em5,em6,em7,em8,em9,em10,em11,em12,em13,em14,em15,em16:std_logic;
--fifo full flags
signal fu1,fu2,fu3,fu4,fu5,fu6,fu7,fu8,fu9,fu10,fu11,fu12,fu13,fu14,fu15,fu16:std_logic;
--read request synchronizer
signal rrsync:std_logic_vector(3 downto 0);
--write request synchronizer
signal wrsync1,wrsync2,wrsync3,wrsync4:std_logic_vector(3 downto 0);
--fifo outputs signals
signal fo1,fo2,fo3,fo4,fo5,fo6,fo7,fo8,fo9,fo10,fo11,fo12,fo13,fo14,fo15,fo16:std_logic_vector(7 downto 0);
--round robin outputs
signal rro1,rro2,rro3,rro4:std_logic_vector(7 downto 0);
--enum for scheduling states
type schedulingstate is(s1,s2,s3,s4);
signal currentSchedulingState:schedulingstate:=s3;
signal nextSchedulingState:schedulingstate;
--read request signals
signal rr1,rr2,rr3,rr4,rr5,rr6,rr7,rr8,rr9,rr10,rr11,rr12,rr13,rr14,rr15,rr16:std_logic;
--write request signals
signal wr_1,wr_2,wr_3,wr_4,wr_5,wr_6,wr_7,wr_8,wr_9,wr_10,wr_11,wr_12,wr_13,wr_14,wr_15,wr_16:std_logic;
--signals for 
begin
--input buffers
buff1: bit8register generic map(8) port map(datai1,wclk,buffo1,wr1,rst);
buff2: bit8register generic map(8) port map(datai2,wclk,buffo2,wr2,rst);
buff3: bit8register generic map(8) port map(datai3,wclk,buffo3,wr3,rst);
buff4: bit8register generic map(8) port map(datai4,wclk,buffo4,wr4,rst);
--switch fabrics;
dem1:bit8demux port map(buffo1,dem1o1,dem1o2,dem1o3,dem1o4,buffo1(1 downto 0),wr1);
dem2:bit8demux port map(buffo2,dem2o1,dem2o2,dem2o3,dem2o4,buffo2(1 downto 0),wr2);
dem3:bit8demux port map(buffo3,dem3o1,dem3o2,dem3o3,dem3o4,buffo3(1 downto 0),wr3);
dem4:bit8demux port map(buffo4,dem4o1,dem4o2,dem4o3,dem4o4,buffo4(1 downto 0),wr4);
--read request signals assignment statements
rr1<=(not em1) and rrsync(2);
rr2<=(not em2) and rrsync(1);
rr3<=(not em3) and rrsync(0);
rr4<=(not em4) and rrsync(3);
rr5<=(not em5) and rrsync(2);
rr6<=(not em6) and rrsync(1);
rr7<=(not em7) and rrsync(0);
rr8<=(not em8) and rrsync(3);
rr9<=(not em9) and rrsync(2);
rr10<=(not em10) and rrsync(1);
rr11<=(not em11) and rrsync(0);
rr12<=(not em12) and rrsync(2);
rr13<=(not em13) and rrsync(1);
rr14<=(not em14) and rrsync(1);
rr15<=(not em15) and rrsync(0);
rr16<=(not em16) and rrsync(3);
--write request signal assignment statements
wr_1<=( not fu1) and wrsync1(3);
wr_2<=( not fu2 )and wrsync2(3);
wr_3<=( not fu3 )and wrsync3(3);
wr_4<=( not fu4 )and wrsync4(3);
wr_5<=( not fu5 )and wrsync1(2);
wr_6<=( not fu6 )and wrsync2(2);
wr_7<=( not fu7 )and wrsync3(2);
wr_8<=( not fu8 )and wrsync4(2);
wr_9<=( not fu9 )and wrsync1(1);
wr_10<=( not fu10) and wrsync2(1);
wr_11<=( not fu11) and wrsync3(1);
wr_12<=( not fu12) and wrsync4(1);
wr_13<= (not fu13) and wrsync1(0);
wr_14<= (not fu14) and wrsync2(0);
wr_15<= (not fu15) and wrsync3(0);
wr_16<= (not fu16) and wrsync4(0);

--fifo reference port for port mapping component fifo is 
--port(reset:in std_logic;rclk,wclk:in std_logic;rreq,wreq:in std_logic;
	--datain:in std_logic_vector(7 downto 0);dataout:out std_logic_vector(7 downto 0);
	--empty,full:out std_logic);
--end component fifo;
--fifos for output queueing
fifo1:fifo port map(rst,rclk,wclk,rr1,wr_1,dem1o1,fo1,em1,fu1);
fifo2:fifo port map(rst,rclk,wclk,rr2,wr_2,dem2o1,fo2,em2,fu2);
fifo3:fifo port map(rst,rclk,wclk,rr3,wr_3,dem3o1,fo3,em3,fu3);
fifo4:fifo port map(rst,rclk,wclk,rr4,wr_4,dem4o1,fo4,em4,fu4);
fifo5:fifo port map(rst,rclk,wclk,rr5,wr_5,dem1o2,fo5,em5,fu5);
fifo6:fifo port map(rst,rclk,wclk,rr6,wr_6,dem2o2,fo6,em6,fu6);
fifo7:fifo port map(rst,rclk,wclk,rr7,wr_7,dem3o2,fo7,em7,fu7);
fifo8:fifo port map(rst,rclk,wclk,rr8,wr_8,dem4o2,fo8,em8,fu8);
fifo9:fifo port map(rst,rclk,wclk,rr9,wr_9,dem1o3,fo9,em9,fu9);
fifo10:fifo port map(rst,rclk,wclk,rr10,wr_10,dem2o3,fo10,em10,fu10);
fifo11:fifo port map(rst,rclk,wclk,rr11,wr_11,dem3o3,fo11,em11,fu11);--fu(11) not FULL (ones not letter L's)
fifo12:fifo port map(rst,rclk,wclk,rr12,wr_12,dem4o3,fo12,em12,fu12);
fifo13:fifo port map(rst,rclk,wclk,rr13,wr_13,dem1o4,fo13,em13,fu13);
fifo14:fifo port map(rst,rclk,wclk,rr14,wr_14,dem2o4,fo14,em14,fu14);
fifo15:fifo port map(rst,rclk,wclk,rr15,wr_15,dem3o4,fo15,em15,fu15);
fifo16:fifo port map(rst,rclk,wclk,rr16,wr_16,dem4o4,fo16,em16,fu16);

--round robin schedulers for synchronizing output buffers with queues
RoundR1:RoundRobinScheduler port map(rst,rclk,fo1,fo2,fo3,fo4,rro1);
RoundR2:RoundRobinScheduler port map(rst,rclk,fo5,fo6,fo7,fo8,rro2);
RoundR3:RoundRobinScheduler port map(rst,rclk,fo9,fo10,fo11,fo12,rro3);
RoundR4:RoundRobinScheduler port map(rst,rclk,fo13,fo14,fo15,fo16,rro4);
datao1<=rro1;
datao2<=rro2;
datao3<=rro3;
datao4<=rro4;
--processes beginining from here are used as the controller module logic
readSynchronizerCS:process(rclk,rst) is
begin
if rst='1' then
currentSchedulingState<=s3;
elsif rising_edge(rclk) then
currentSchedulingState<=nextSchedulingState;
else null;
end if;
end process readSynchronizerCS;
readSynchronizerNS:process(currentSchedulingState) is
begin

case currentSchedulingState is
	when s1=> 
		nextSchedulingState<=s2;
	
	when s2=> 	
		nextSchedulingState<=s3;
	
	when s3=> 
		nextSchedulingState<=s4;
	
	when s4=> 
	
		nextSchedulingState<=s1;
		
	when others=>
		null;
end case;
end process readSynchronizerNS;

readSynchronizerOP:process(currentSchedulingState) is
begin

case currentSchedulingState is
	when s1=> 
		rrsync<="1000";
	
	when s2=> 	
		rrsync<="0100";
	
	when s3=> 
		rrsync<="0010";
	when s4=> 
		rrsync<="0001";
	when others=>
		null;
end case;
end process readSynchronizerOP;
--write request synchronization for input buffer1
writerequest1:process(datai1 (1 downto 0),wclk,wr1) is
begin 
if (rising_edge(wclk)and wr1='1') then
case datai1 (1 downto 0) is
	when "00"=>
		wrsync1<="1000";
	when "01"=>
		wrsync1<="0100";
	when "10"=>
		wrsync1<="0010";
	when "11"=>
		wrsync1<="0001";
	when others=> null;
end case;
else null;
end if;
end process writerequest1;
--write request synchronization for input buffer2
writerequest2:process(datai2 (1 downto 0),wclk,wr2) is
begin 
if (rising_edge(wclk) and wr2='1' )then
case datai2 (1 downto 0) is
	when "00"=>
		wrsync2<="1000";
	when "01"=>
		wrsync2<="0100";
	when "10"=>
		wrsync2<="0010";
	when "11"=>
		wrsync2<="0001";
	when others=> null;
end case;
else null;
end if;
end process writerequest2;
--write request synchronization for input buffer3
writerequest3:process(datai3 (1 downto 0),wclk,wr3) is
begin 
if (rising_edge(wclk) and wr3='1') then
case datai3 (1 downto 0) is
	when "00"=>
		wrsync3<="1000";
	when "01"=>
		wrsync3<="0100";
	when "10"=>
		wrsync3<="0010";
	when "11"=>
		wrsync3<="0001";
	when others=> null;
end case;
else null;
end if;
end process writerequest3;
--write request synchronization for input buffer4
writerequest4:process(datai4 (1 downto 0),wclk,wr4) is
begin 
if (rising_edge(wclk)and wr4='1') then
case datai4 (1 downto 0) is
	when "00"=>
		wrsync4<="1000";
	when "01"=>
		wrsync4<="0100";
	when "10"=>
		wrsync4<="0010";
	when "11"=>
		wrsync4<="0001";
	when others=> null;
end case;
else null;
end if;
end process writerequest4;
end architecture mixed;