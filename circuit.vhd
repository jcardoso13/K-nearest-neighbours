library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity circuit is

port(
clk, rst: in std_logic;
reg_input_x,reg_input_y,
	reg_input_x0,reg_input_y0: in signed(8 downto 0);
	
	reg_input_Q00,reg_input_Q01,
	reg_input_Q10,reg_input_Q11: in signed(9 downto 0);
	output: out std_logic_vector(9 downto 0)
);
end circuit;


architecture Behavioral of circuit is

component control_unit
port(
	clk: in std_logic;
	rst: in std_logic; 
	sel_reg1: out std_logic_vector(2 downto 0);
	sel_reg2: out std_logic_vector(2 downto 0);
	sel_reg3: out std_logic_vector(2 downto 0);
	sel_reg4: out std_logic_vector(2 downto 0);
	sel_reg5: out std_logic_vector(1 downto 0);
	sel_reg6: out std_logic_vector(1 downto 0);
	sel_out1: out std_logic_vector(1 downto 0);
	sel_out2: out std_logic_vector(1 downto 0);
	sel_out3: out std_logic_vector(1 downto 0);
	sel_out4: out std_logic_vector(1 downto 0);
	load: out std_logic_vector(3 downto 0);
	sel_add: out std_logic_vector(1 downto 0);
	trunc: out std_logic;
	seq: out std_logic;
	done: out std_logic
);
end component;

component datapath_unit is
port(
	clk: in std_logic;
	rst: in std_logic;
	sel_reg1: in std_logic_vector(2 downto 0);
	sel_reg2: in std_logic_vector(2 downto 0);
	sel_reg3: in std_logic_vector(2 downto 0);
	sel_reg4: in std_logic_vector(2 downto 0);
	sel_reg5: in std_logic_vector(1 downto 0);
	sel_reg6: in std_logic_vector(1 downto 0);
	sel_out1: in std_logic_vector(1 downto 0);
	sel_out2: in std_logic_vector(1 downto 0);
	sel_out3: in std_logic_vector(1 downto 0);
	sel_out4: in std_logic_vector(1 downto 0);
	load: in std_logic_vector(3 downto 0);
	seq: in std_logic;
	sel_add: in std_logic_vector(1 downto 0);
	trunc: in std_logic;
	reg_input_x, reg_input_y,
     reg_input_x0, reg_input_y0: in signed(8 downto 0);
     reg_input_Q00, reg_input_Q01,
        reg_input_Q10,reg_input_Q11: in signed(9 downto 0);
    output: out std_logic_vector(9 downto 0);
    done: in std_logic
);
end component;

signal 	sel_reg1,sel_reg2,sel_reg3,sel_reg4: std_logic_vector(2 downto 0);
signal 	sel_reg5,sel_reg6: std_logic_vector(1 downto 0); 
signal sel_out1,sel_out2,sel_out3,sel_out4:std_logic_vector(1 downto 0);
signal load: std_logic_vector(3 downto 0);
signal seq: std_logic;
signal sel_add:std_logic_vector(1 downto 0);
signal trunc:std_logic;
signal done: std_logic;

begin

inst_control: control_unit port map (
	clk => clk,
	rst => rst,
	sel_reg1 => sel_reg1,
	sel_reg2 => sel_reg2,
	sel_reg3 => sel_reg3,
	sel_reg4 => sel_reg4,
	sel_reg5 => sel_reg5,
	sel_reg6 => sel_reg6,
	sel_out1 => sel_out1,
	sel_out2 => sel_out2,
	sel_out3 => sel_out3,
	sel_out4 => sel_out4,
	load => load,
	sel_add => sel_add, 
	trunc => trunc,
	seq => seq,
	done => done
);

inst_datapath: datapath_unit port map (
	clk => clk,
	rst => rst,
	sel_reg1 => sel_reg1,
	sel_reg2 => sel_reg2,
	sel_reg3 => sel_reg3,
	sel_reg4 => sel_reg4,
	sel_reg5 => sel_reg5,
	sel_reg6 => sel_reg6,
	sel_out1 => sel_out1,
	sel_out2 => sel_out2,
	sel_out3 => sel_out3,
	sel_out4 => sel_out4,
	load => load,
	sel_add => sel_add, 
	trunc => trunc,
	seq => seq,
	reg_input_x=>reg_input_x,
	reg_input_y=>reg_input_y,
    reg_input_x0=>reg_input_x0,
    reg_input_y0=>reg_input_y0,
    reg_input_Q00=>reg_input_Q00,
    reg_input_Q01=>reg_input_Q01,
    reg_input_Q10=>reg_input_Q10,
    reg_input_Q11=>reg_input_Q11,
    output => output,
    done => done
);

end Behavioral;
