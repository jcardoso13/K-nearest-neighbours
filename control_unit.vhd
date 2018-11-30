library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity control_unit is

port(
	--input--
	clk: in std_logic;
	rst: in std_logic;
	init: in std_logic;
	k: in std_logic;
	
	--output--
	k_out: out std_logic;
	load: out std_logic
);

end control_unit;


architecture Behavioral of control_unit is

	type fsm_states is ( s_initial, s_execution,s_end);
	signal currstate, nextstate: fsm_states;
	

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
	
state_comb: process (currstate,rst)

begin  --  process
    nextstate <= currstate ;  
    -- by default, does not change the state.
    
	case currstate is
		when s_initial =>
			nextstate <= s_execution;
			
		when s_execution =>
			nextstate <= s_end;
			
		when s_end =>
			nextstate <= s_initial;
			
	 end case;
 end process;
end Behavioral;
