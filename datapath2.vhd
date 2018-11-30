library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath2 is
port(
    clk,rst,load: in std_logic;
	A: in signed(33 downto 0);
	k: in std_logic_vector(2 downto 0);
    result: out std_logic_vector(1 downto 0)
	);
end datapath2;


architecture Behavioral of datapath2 is


begin


end Behavioral;
