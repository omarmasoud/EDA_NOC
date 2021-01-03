library ieee;
USE ieee.std_logic_1164.ALL;
USE iee.numeric_std.ALL;

ENTITY routerTestBench is
END routerTestBench;

architecture behavior OF routerTestBench is

--Router Decleration
COMPONENT router is
generic(n:integer :=8);
port (datai1,datai2,datai3,datai4:in std_logic_vector(n-1 downto 0);
        datao1,datao2,datao3,datao4:out std_logic_vector(n-1 downto 0);
        wr1,wr2,wr3,wr4,rst,wclk,rclk:in std_logic
);
end component router;
---------------------------------------------

--Router Inputs
signal datai1,datai2,datai3,datai4:std_logic_vector(n-1 downto 0);
signal wr1,wr2,wr3,wr4,rst,rclk,wclk:std_logic:='0';
--Router Outputs
signal datao1,datao2,datao3,datao4:std_logic_vector(n-1 downto 0);
---------------------------------------------
--Clock Periods
constant wClkPeriod: time:=20 ns;
constant rClkPeriod: time:=20 ns;
---------------------------------------------

begin

--Router Instaniation
myRouter: router PORT MAP(
        datai1=> datai1;
        datai2=> datai2;
        datai3=> datai3;
        datai4=> datai4;
            rst=>rst;
            rclk=>rclk;
            wclk=>wclk;
            wr1=>wr1;
            wr2=>wr2;
            wr3=>wr3;
            wr4=>wr4;
       
        datao1=>datao1;
        datao2=>datao2;
        datao3=>datao3;
        datao4=>datao4    
); 
-----------------------------------------------
