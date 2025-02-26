library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
entity RoundRobinScheduler is 
	port(
	reset:in std_logic;
	clock:in std_logic;
	din1,din2,din3,din4:in std_logic_vector( 7 downto 0);
	dout:out std_logic_vector( 7 downto 0));
end entity RoundRobinScheduler;
architecture moorefsm of RoundRobinScheduler is
type SchedState is(s1,s2,s3,s4);
signal CurrentState:SchedState:=s4;--let start from s4 so the first clock edge will make s1 happen and let din1 go to dout 
signal NextState:SchedState;
begin
cs:process(clock,reset)is
begin
--reset was added so when router resets we go to initial state
if reset='1' then
 CurrentState<=s4;
elsif rising_edge(clock) then
 CurrentState<=NextState;
else null;
end if;
end process cs; 
ns:process(CurrentState)is
begin
case(CurrentState) is
when s1=>
	NextState<=s2;
when s2=>
	NextState<=s3;
when s3=>
	NextState<=s4;
when s4=>
	NextState<=s1;
end case;
end process ns;
op:process(CurrentState)is
begin
case(CurrentState) is
when s1=>
	dout<=din1;
when s2=>
	dout<=din2;
when s3=>
	dout<=din3;
when s4=>
	dout<=din4;
end case;
end process op;
end architecture moorefsm;
