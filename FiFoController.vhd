library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;
entity FiFoController is
--generic(n:integer:=2);
	port(reset:in std_logic;rdclk,wrclk:in std_logic;r_req,w_req:in std_logic;
	write_valid,read_valid,empty,full:out std_logic;
	wr_ptr,rd_ptr:out std_logic_vector(2 downto 0));
end entity FiFoController;
architecture mixed of FiFoController is
component GreyCounter is
generic(n:natural:=3);
port ( en,rst:in std_logic;clk: in std_logic;
 	d_out: out std_logic_vector(n-1 downto 0));
end component GreyCounter;
component graytobinary is
generic(n:natural:=3);
port(grayin:in std_logic_vector(n-1 downto 0);
	grayout:out std_logic_vector(n-1 downto 0));
end component graytobinary;
for gcounterwrite : GreyCounter use entity work.Greycounter(behaviour);
for gcounterread : GreyCounter use entity work.Greycounter(behaviour);
for gtobinwrite :graytobinary use entity work.graytobinary(behave);
for gtobinread :graytobinary use entity work.graytobinary(behave);

type lastop is(rd,wr); -- a type to check the last operation done using the controller to check if empty or not
--signal prevoperation3:lastop:=rd;
--signal prevoperation1,prevoperation2:lastop;
signal rv,wv:std_logic;
signal rptr:std_logic_vector(2 downto 0);
signal wptr:std_logic_vector(2 downto 0);
signal rptrcount:std_logic_vector(2 downto 0);
signal wptrcount:std_logic_vector(2 downto 0);
signal em,fu:std_logic;
begin
rd_ptr<=rptr;
wr_ptr<=wptr;
read_valid<=rv;
write_valid<=wv;
gcounterwrite:GreyCounter generic map(3) port map(wv ,reset,wrclk,wptrcount);
gtobinwrite:graytobinary generic map(3) port map (wptrcount,wptr);
gcounterread:GreyCounter generic map(3) port map(rv,reset,rdclk,rptrcount);
gtobinread:graytobinary generic map(3) port map (rptrcount,rptr);

emptyOrFull:process(wptr,rptr) is
begin
if wptr+1=rptr then
	fu<='1';
	em<='0';
elsif rptr=wptr then
em<='1';
fu<='0';
else 
em<='0';
fu<='0';
end if;
end process emptyOrFull;
empty<=em;
full<=fu;
rv<=(not em) and r_req;
wv<=(not fu)and w_req;

end architecture mixed;