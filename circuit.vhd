library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity circuit is

port(
	clk in std_logic; 
	rst: in std_logic;
	init: in std_logic;
	result: out std_logic_vector(1 downto 0)
);
end circuit;


architecture Behavioral of circuit is

component control_unit
port(
	clk: in std_logic;
	rst: in std_logic;
	init: in std_logic;
	k_out: out std_logic;
	load: out std_logic;
);
end component;

component datapath1 is
port(
	clk: in std_logic;
    rst: in std_logic;
	load: in std_logic;
	A: in unsigned(63 downto 0); 
	B: in unsigned(63 downto 0);
    C: out signed(33 downto 0) 
	
);
end component;

component datapath2 is
port(
	
	clk: in std_logic;
	rst: in std_logic;
	load: in std_logic;
	A: in signed(33 downto 0);
	k: in std_logic_vector(2 downto 0);
    result: out std_logic_vector(1 downto 0)
end component;

component mem is
port(
	clk: in std_logic;
	rst: in std_logic;
	load: in std_logic;
	operand: in unsigned(15 downto 0);
	init: in std_logic
	

    );

begin

inst_control: control_unit port map (
	clk => clk,
	rst => rst,
	init => init,
	load => load,
	k_out => k_out
);

inst_datapath1: datapath1 port map (
	clk => clk,
	rst => rst,
	load => load,
	A => A,
	k => k_out,
	result => result
);

inst_datapath2: datapath2 port map (
	clk => clk,
	rst => rst,
	load => load, 
	A => A,
	B => B,
	C => C
);

inst_mem: mem port map (
	clk => clk,
	rst => rst,
	load => load,
	operand =>operand,
	init => init
);

end Behavioral;
