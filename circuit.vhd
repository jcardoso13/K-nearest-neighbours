library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity circuit is

port(
	clk: in std_logic; 
	rst: in std_logic;
	init: in std_logic;
	new_instance: in std_logic_vector(63 downto 0);
	k: in std_logic_vector(2 downto 0);
	result: out std_logic_vector(1 downto 0)
);
end circuit;


architecture Behavioral of circuit is

component control_unit
port(
	-- INPUTS --
	clk: in std_logic;
	rst: in std_logic;
	init: in std_logic;
	done: in std_logic;
	k: in std_logic_vector (2 downto 0);
	new_instance: in std_logic_vector( 63 downto 0);
	k_out: out std_logic_vector(2 downto 0); -- FOR DATAPATH2
	load: out std_logic_vector(1 downto 0); -- FOR DATAPATH1 AND DATAPATH2
	instance: out std_logic_vector (63 downto 0); -- FOR DATAPATH1
	result_ready: out std_logic -- FOR THE FPGA
);
end component;

component datapath1 is
port(
	clk: in std_logic;
    rst: in std_logic;
	load: in std_logic_vector(1 downto 0);
	A_in: in std_logic_vector(63 downto 0); 
	B_in: in std_logic_vector(63 downto 0);
    C: out unsigned(31 downto 0) ;
	valid: in std_logic;
	valid_result: out std_logic
);
end component;

component datapath2 is
port(
	
   clk,rst: in std_logic;
   load : in std_logic_vector (1 downto 0);
   valid : in std_logic; --valid for the datapath1
   A: in unsigned(31 downto 0);
   class: in std_logic_vector(1 downto 0);
   k_data2: in std_logic_vector(2 downto 0);
  class_out: out std_logic_vector(1 downto 0);
   done : out std_logic --to the control unit
    );
end component;

component mem is
port(
    clk,rst: in std_logic;
    init: in std_logic;
    data_out: out std_logic_vector(63 downto 0);
    class_out: out std_logic_vector(1 downto 0);
    valid: out std_logic -- to enter in the datapath1

    );
end component;

signal load: std_logic_vector(1 downto 0);
signal k_out: std_logic_vector(2 downto 0);
signal operand: std_logic_vector(63 downto 0);
signal operand_class: std_logic_vector(1 downto 0);
signal instance: std_logic_vector(63 downto 0);
signal result_ready: std_logic;
signal done: std_logic;
signal valid_mem: std_logic;
signal valid_result: std_logic;
signal C: unsigned(31 downto 0);


begin

inst_control: control_unit port map (
	clk => clk,
	rst => rst,
	init => init,
	load => load,
	k => k,
	k_out => k_out,
	instance => instance,
	new_instance => new_instance,
	result_ready => result_ready,
	done => done
);

inst_datapath1: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand,
	valid => valid_mem,
	valid_result => valid_result,
	C => C
);

inst_datapath2: datapath2 port map(
	clk => clk,
	rst => rst,
	valid => valid_result,
	k_data2 => k_out,
	A => C, -- C is the result from datapath1
	class => operand_class,
	class_out => result,
	load => load,
	done => done
	
);

inst_mem: mem port map (
	clk => clk,
	rst => rst,
	valid => valid_mem,
	data_out=> operand,
	class_out => operand_class,
	init => init
);

end Behavioral;
