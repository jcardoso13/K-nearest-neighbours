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
	k: in std_logic_vector (2 downto 0);
	
	new_instance: in std_logic_vector( 63 downto 0);
	
	
	-- OUTPUTS --
	k_out: out std_logic_vector(2 downto 0); -- FOR DATAPATH2
	load: out std_logic_vector(1 downto 0); -- FOR DATAPATH1 AND DATAPATH2
	instance: out std_logic_vector (63 downto 0); -- FOR MEM.VHD
	result_ready: out std_logic -- FOR THE FPGA
);

end control_unit;


architecture Behavioral of control_unit is

	type fsm_states is ( s_initial, s_new_instance, s_old_instance ,s_end);
	signal currstate, nextstate: fsm_states;
	signal previous_state: std_logic_vector(63 downto 0);

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
	
state_comb: process (currstate,rst,init)

begin  --  process
    nextstate <= currstate ;  
    -- by default, does not change the state.
    
	case currstate is
		when s_initial =>
		if init = '1' then 
			if (new_instance = previous_state) then
			nextstate <= s_new_instance;
			else nextstate <= s_old_instance;	
			end if;
			instance <= new_instance; 
			result_ready <= '0';
		end if;
		
			
			
		when s_new_instance =>
		if (done = '1') then 
		nextstate <= s_end;
		end if;
			load <= "11"; -- LOAD FOR DATAPATH1 AND DATAPATH2
			k_out <= k;
		
		when s_old_instance =>
		if (done ='1') then 
		nextstate <= s_end;
		end if;
			load <= "01"; -- LOAD ONLY FOR DATAPATH2
			k_out <= k;
		when s_end =>
		
			nextstate <= s_initial;
			load <= "00";
			k_out <= "000";	
			previous_state <= new_instance; -- TO COMPARE IN THE NEXT LOOP
			instance <= (others => '0'); 
			result_ready <= '1'; -- FOR THE FPGA 
			
	 end case;
 end process;
end Behavioral;
