library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath1 is
port(
    clk: in std_logic;
    rst: in std_logic;
	A: in unsigned(63 downto 0); --Q3.13
	B: in unsigned(63 downto 0);
    load: in std_logic;
    C: out signed(33 downto 0) -- Q8.26
);
end datapath1;


architecture Behavioral of datapath1 is


begin


end Behavioral;
