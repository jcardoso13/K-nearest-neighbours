library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder is
port(
	A: in signed(10 downto 0);
	B: in signed(10 downto 0);
	C: out signed(10 downto 0);
	sel_add: in std_logic
	--trunc: in std_logic
	);
end adder;


architecture Behavioral of adder is
--signal aux: signed(9 downto 0);


begin
C <= A+B when sel_add='0' else A-B;
--C <= (9 downto 5 => aux(9)) & aux(9 downto 5) when trunc='1' else aux;

end Behavioral;
