library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
entity fifocontroltest is 
end entity fifocontroltest;
architecture behave of fifocontroltest is 
component FiFoController is
	port(reset:in std_logic;rdclk,wrclk:in std_logic;r_req,w_req:in std_logic;
	write_valid,read_valid,empty,full:out std_logic;
	wr_ptr,rd_ptr:out std_logic_vector(2 downto 0));
end component FiFoController;
for fc:FiFoController use entity work.FiFoController(mixed);
signal reset,r_req,w_req,write_valid,read_valid,empty,full :std_logic;
signal rdclk,wrclk:std_logic;
signal wr_ptr,rd_ptr: std_logic_vector(2 downto 0);
begin
fc:FiFoController port map(reset,rdclk,wrclk,r_req,w_req,write_valid,read_valid,empty,full,wr_ptr,rd_ptr);
w_req<='1';
c1:process is
begin
wait for 20ns;
if rdclk='1' then
	rdclk<='0';
else
	rdclk<='1';
end if;
end process c1;
c2:process is
begin
wait for 20ns;
if wrclk='1' then
	wrclk<='0';
else
	wrclk<='1';
end if;
end process c2;


end architecture behave;
