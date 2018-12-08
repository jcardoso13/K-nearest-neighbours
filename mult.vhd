library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mult is
port(
	A: in signed(16 downto 0);  -- Q4.13 --
	B: in signed(16 downto 0);  -- Q4.13 --
	C: out signed(33 downto 0); -- Q8.26 --
	);
end mult;


architecture Behavioral of mult is


begin
C <= A*B;

end Behavioral;
