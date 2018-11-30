library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder is
port(
	A: in unsigned(16 downto 0); -- Q4.13 --
	B: in unsigned(16 downto 0); -- Q4.13--
	C: out unsigned(16 downto 0); --Q4.13--
	sel_add: in std_logic
	);
end adder;


architecture Behavioral of adder is



begin
C <= A+B when sel_add='0' else A-B;

end Behavioral;
