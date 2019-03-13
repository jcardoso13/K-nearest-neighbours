library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity control_unit is

port(
	-- INOUTS --
	clk: in std_logic;
	rst: in std_logic;
	init: in std_logic;
	done: in std_logic;
	k: in std_logic_vector (1 downto 0);
	
	new_instance: in std_logic_vector( 63 downto 0);
	option: in std_logic;
	
	
	-- OUTPUTS --
	k_out: out std_logic_vector(1 downto 0); -- FOR DATAPATH2
	load: out std_logic_vector(1 downto 0); -- FOR DATAPATH1 AND DATAPATH2
	instance: out std_logic_vector (63 downto 0); -- FOR MEM.VHD
	result_ready: out std_logic -- FOR THE FPGA
);

end control_unit;


architecture Behavioral of control_unit is

	type fsm_states is ( s_initial, s_new_instance, s_old_instance ,s_end);
	signal currstate, nextstate: fsm_states;
	signal instance_buff: std_logic_vector(63 downto 0);
--signal instance_buff: std_logic_vector(63 downto 0);

begin
	state_reg: process (clk)
	begin
		if clk'event and clk = '1' then
			if rst = '1' then
				currstate <= s_initial ;
			else
				currstate <= nextstate ;
			end if ;
		end if ;
	end process;
	
state_comb: process (currstate,rst,init, done,k,option)

begin  --  process
    nextstate <= currstate ;
    -- by default, does not change the state.
    
	case currstate is
		when s_initial =>
			if init='1' and option='1'  then nextstate <= s_new_instance;	
			end if;
			result_ready <= '0';
			load <= "00";
			k_out <= "00";
		when s_new_instance =>
		if (done = '1') then 
			nextstate <= s_end;
		end if;
			load <= "11"; -- LOAD FOR DATAPATH1 AND DATAPATH2
			k_out <= k;
			result_ready <= '0';
		when s_old_instance =>
		if (done ='1') then 
			nextstate <= s_end;
		end if;
			load <= "01"; -- LOAD ONLY FOR DATAPATH2
			result_ready <= '0';
			k_out <= k;
		when s_end =>
			nextstate <= s_initial;
			load <= "00";
			k_out <= "00";	
			result_ready <= '1'; -- FOR THE FPGA 
				
	 end case;
 end process;

instance<=new_instance;
 
 
 
 
 
end Behavioral;
