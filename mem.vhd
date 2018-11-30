--Training Memory with Counter, outputs both operands


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mem is
port(
    clk,rst,load: in std_logic;
	operand: in unsigned(15 downto 0);
	init: in std_logic
	);
end mem;


architecture Behavioral of mem is


begin


end Behavioral;
