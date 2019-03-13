library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity circuit is

port(
	clk: in std_logic; 
	rst: in std_logic;
	init: in std_logic;
	new_instance: in std_logic_vector(63 downto 0);
	k: in std_logic_vector(1 downto 0);
	option: in std_logic;
	result: out std_logic_vector(1 downto 0);
	result_ready: out std_logic
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
	option: in std_logic;
	k: in std_logic_vector (1 downto 0);
	new_instance: in std_logic_vector( 63 downto 0);
	k_out: out std_logic_vector(1 downto 0); -- FOR DATAPATH2
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

component decision is
port(

    clk,rst: in std_logic;
	load : in std_logic_vector (1 downto 0);
	class: in std_logic_vector(1 downto 0);
	valid: in std_logic_vector(17 downto 0);
	k: in std_logic_vector(1 downto 0);
	A: in std_logic_vector(575 downto 0);
	done: out std_logic;
	
	
	
	class_out : out std_logic_vector(1 downto 0)
	
	
	);
end component;

component mem is
port(
    clk,rst: in std_logic;
    init: in std_logic;
    data_out: out std_logic_vector(1151 downto 0);
    class_out: out std_logic_vector(1 downto 0);
    valid: out std_logic -- to enter in the datapath1

    );
end component;

signal load: std_logic_vector(1 downto 0);
signal k_out: std_logic_vector(1 downto 0);
signal operand: std_logic_vector(1151 downto 0);
signal operand_class: std_logic_vector(1 downto 0);
signal instance: std_logic_vector(63 downto 0);
signal done: std_logic;
signal valid_mem: std_logic;
signal valid_result: std_logic_vector(17 downto 0);
signal C: unsigned(575 downto 0);


begin

inst_control: control_unit port map (
	clk => clk,
	rst => rst,
	init => init,
	load => load,
	k => k,
	k_out => k_out,
	option=>option,
	instance => instance,
	new_instance => new_instance,
	result_ready => result_ready,
	done => done
);

inst_datapath1_0: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(63 downto 0),
	valid => valid_mem,
	valid_result => valid_result(0),
	C => C(31 downto 0)
);

inst_datapath1_1: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(127 downto 64),
	valid => valid_mem,
	valid_result => valid_result(1),
	C => C(63 downto 32)
);

inst_datapath1_2: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(191 downto 128),
	valid => valid_mem,
	valid_result => valid_result(2),
	C => C(95 downto 64)
);

inst_datapath1_3: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(255 downto 192),
	valid => valid_mem,
	valid_result => valid_result(3),
	C => C(127 downto 96)
);


inst_datapath1_4: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(319 downto 256),
	valid => valid_mem,
	valid_result => valid_result(4),
	C => C(159 downto 128)
);

inst_datapath1_5: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(383 downto 320),
	valid => valid_mem,
	valid_result => valid_result(5),
	C => C(191 downto 160)
);

inst_datapath1_6: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(447 downto 384),
	valid => valid_mem,
	valid_result => valid_result(6),
	C => C(223 downto 192)
);

inst_datapath1_7: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(511 downto 448),
	valid => valid_mem,
	valid_result => valid_result(7),
	C => C(255 downto 224)
);

inst_datapath1_8: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(575 downto 512),
	valid => valid_mem,
	valid_result => valid_result(8),
	C => C(287 downto 256)
);

inst_datapath1_9: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(639 downto 576),
	valid => valid_mem,
	valid_result => valid_result(9),
	C => C(319 downto 288)
);

inst_datapath1_10: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(703 downto 640),
	valid => valid_mem,
	valid_result => valid_result(10),
	C => C(351 downto 320)
);

inst_datapath1_11: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(767 downto 704),
	valid => valid_mem,
	valid_result => valid_result(11),
	C => C(383 downto 352)
);

inst_datapath1_12: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(831 downto 768),
	valid => valid_mem,
	valid_result => valid_result(12),
	C => C(415 downto 384)
);

inst_datapath1_13: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(895 downto 832),
	valid => valid_mem,
	valid_result => valid_result(13),
	C => C(447 downto 416)
);

inst_datapath1_14: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(959 downto 896),
	valid => valid_mem,
	valid_result => valid_result(14),
	C => C(479 downto 448)
);

inst_datapath1_15: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(1023 downto 960),
	valid => valid_mem,
	valid_result => valid_result(15),
	C => C(511 downto 480)
);

inst_datapath1_16: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(1087 downto 1024),
	valid => valid_mem,
	valid_result => valid_result(16),
	C => C(543 downto 512)
);

inst_datapath1_17: datapath1 port map(
	clk => clk,
	rst => rst,
	load => load,
	A_in => instance,
	B_in => operand(1151 downto 1088),
	valid => valid_mem,
	valid_result => valid_result(17),
	C => C(575 downto 544)
);

inst_decision: decision port map(
	clk => clk,
	rst => rst,
	valid => valid_result,
	k => k_out,
	A => std_logic_vector(C), -- C is the result from datapath1
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
	init => load(1)
);

end Behavioral;
