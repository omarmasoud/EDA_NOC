library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
entity fifo is 
port(reset:in std_logic;rclk,wclk:in std_logic;rreq,wreq:in std_logic;
	datain:in std_logic_vector(7 downto 0);dataout:out std_logic_vector(7 downto 0);
	empty,full:out std_logic);
end entity fifo;
architecture Structural of fifo is 
component FiFoController is
--generic(n:integer:=2);
	port(reset:in std_logic;rdclk,wrclk:in std_logic;r_req,w_req:in std_logic;
	write_valid,read_valid,empty,full:out std_logic;
	wr_ptr,rd_ptr:out std_logic_vector(2 downto 0));
end component FiFoController;

component BlockRam is 
	port(din:in std_logic_vector(7 downto 0);
	dout:out std_logic_vector(7 downto 0);
 	wea,rea:in std_logic;clka,clkb:in std_logic;
	addra,addrb:in std_logic_vector(2 downto 0));
end component BlockRam;

for fcontroller:FiFoController use entity work.FiFoController(behave);
for ram:BlockRam use entity work.BlockRam(behave);
signal wv,rv,emp,fu:std_logic;
signal addresswrite,adressread:std_logic_vector(2 downto 0);
signal output:std_logic_vector(7 downto 0);
begin
fcontroller:FiFoController  port map(reset,rclk,wclk,rreq,wreq,wv,rv,emp,fu,addresswrite,adressread);
ram:BlockRam port map(datain,output,wv,rv,wclk,rclk,addresswrite,adressread);
dataout<=output;
empty<=emp;
full<=fu;
end architecture Structural;
