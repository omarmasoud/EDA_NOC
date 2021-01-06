
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
type wrsyncbit is array (3 downto 0)
begin

gen_fifo: for i in 15 downto 0 generate

 fifo  
port map(rst,rclk,wclk,rrsync);
 end generate gen_fifo;
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
readSynchronizerNSandOP:process(currentSchedulingState) is
begin

case currentSchedulingState is
	when s1=> 
		rrsync<="1000";
		nextSchedulingState<=s2;
	
	when s2=> 	
		rrsync<="0100";
		nextSchedulingState<=s3;
	
	when s3=> 
		rrsync<="0010";
		nextSchedulingState<=s4;
	
	when s4=> 
		rrsync<="0001";
		nextSchedulingState<=s1;
		
	when others=>
		null;
end case;

end process readSynchronizerNSandOP;
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

end architecture mixed;