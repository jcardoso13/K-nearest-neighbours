library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder is
port(
	A: in signed(31 downto 0); -- Q6.26 --
	B: in signed(31 downto 0); -- Q6.26 --
	C: out signed(31 downto 0) -- Q6.26 --

	);
end adder;


architecture Behavioral of adder is



begin
C <= A+B; 

end Behavioral;
