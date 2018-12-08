library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity subtractor is
port(
	A: in signed(16 downto 0); -- Q4.13 --
	B: in signed(16 downto 0); -- Q4.13 --
	C: out signed(16 downto 0) -- Q4.13 --

	);
end subtractor;


architecture Behavioral of subtractor is



begin
C <= A-B; 

end Behavioral;
