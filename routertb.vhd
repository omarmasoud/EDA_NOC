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
signal w1,w2,w3,w4:std_logic:='1';
signal rst:std_logic:='0';
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

 

inputtingProcess: process is
begin
w1<='1';
w2<='1';
w3<='1';
w4<='1';

 

 

di1<="00000000";
di2<="00000101";
di3<="00001010";
di4<="00001111";

 

wait for 4 ns;

 

di1<="00000001";
di2<="00000110";
di3<="00001011";
di4<="00001100";

 

wait for 4 ns;

 

di1<="00000010";
di2<="00000111";
di3<="00001000";
di4<="00001101";

 

wait for 4 ns;

 

di1<="00000011";
di2<="00000100";
di3<="00001001";
di4<="00001110";
wait for 4 ns;

 

di1<="XXXXXXXX";
di2<="XXXXXXXX";
di3<="XXXXXXXX";
di4<="XXXXXXXX";
wait for 20 ns;
rst <='1';

 

wait for 4 ns ;
rst <='0';
di1<="00000001";
di2<="01000001";
di3<="10000001";
di4<="11000001";

 


wait;

 

end process inputtingProcess;

 

p1:process is
begin
--rst<='1';
--wait for  2.286ns;

 


--wait for 4 ns;
--w1<='0';
--w2<='0';
--w3<='1';
--w4<='1';
--di1<="10100111";
--di2<="10101100";
--di3<="11111101";
--di4<="11111111";
--wait for  3 ns;
--di1<="10100100";
--di2<="10101101";
--di3<="11111111";
--di4<="00000110";

 

wait for  13 ns;
if (do3="00001010") then REPORT "no problem with reading output from di3 in destenation do3" severity note;
end if;
ASSERT  (do3="00001010") REPORT "Problem with reading output from di3 in destenation do3" SEVERITY error;
wait for 4 ns;

 

if (do4="00001111") then REPORT "no problem with reading output from di4 in destenation do4" severity note;
end if;
ASSERT  (do4="00001111") REPORT "Problem with reading output from di4 in destenation do4" SEVERITY error;
wait for 4 ns;

 

if (do1="00000000") then REPORT "no problem with reading output from di1 in destenation do1" severity note;
end if;
ASSERT do1="00000000" REPORT "Problem with reading output from di1 in destenation do1" SEVERITY error;
wait for 4 ns;

 

if (do2="000000101") then REPORT "No problem with reading output from di2 in destenation do2" severity note;
end if;
ASSERT do2="00000101" REPORT "Problem with reading output from di2 in destenation do2" SEVERITY error;

 


wait;
end process p1;

 

end architecture behave;