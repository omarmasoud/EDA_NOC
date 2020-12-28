library ieee;
use ieee.std_logic_1164.all;
entity bit8demux is 
	port(d_in: in std_logic_vector(7 downto 0);
	d_out1:out std_logic_vector (7 downto 0);
	d_out2:out std_logic_vector (7 downto 0);
	d_out3:out std_logic_vector (7 downto 0);
	d_out4:out std_logic_vector (7 downto 0);
	sel:in std_logic_vector(1 downto 0);
	En: in std_logic);
end entity bit8demux;
architecture behaviour of bit8demux is
 
begin
p:process
begin

	if En='1' then
		case sel is
			when"00"=>d_out1<=d_in;
			when"01"=>d_out2<=d_in;
			when"10"=>d_out3<=d_in;
			when"11"=>d_out4<=d_in;
			when others=> null;
		end case;
end if;


end process p;
end architecture behaviour;