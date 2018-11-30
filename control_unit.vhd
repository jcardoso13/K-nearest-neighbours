library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity control_unit is

port(
	clk: in std_logic;
	rst: in std_logic;
	sel_reg1,sel_reg2,sel_reg3,sel_reg4:out std_logic_vector(2 downto 0);
	sel_reg5,sel_reg6: out std_logic_vector(1 downto 0); 
	sel_out1,sel_out2,sel_out3,
	sel_out4: out std_logic_vector(1 downto 0);
	load: out std_logic_vector(3 downto 0);
	sel_add: out std_logic_vector(1 downto 0);
	done: out std_logic;
	trunc: out std_logic;
	seq: out std_logic
	

);

end control_unit;


architecture Behavioral of control_unit is

	type fsm_states is ( s_initial, s_cycle1, s_cycle2, s_cycle3, s_cycle4, s_cycle5, s_cycle6,s_end);
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
			nextstate <= s_cycle1;
	    		load <="0000";
        		sel_reg1 <= "XXX";
        		sel_reg2 <= "XXX";
        		sel_reg3 <= "XXX";
        		sel_reg4 <= "XXX";
		        sel_reg5 <= "XX";
		        sel_reg6 <= "XX";
        		sel_out1 <= "XX";
       			sel_out2 <= "XX";
        		sel_out3 <= "XX";
        		sel_out4 <= "XX";
        		sel_add <= "XX";
        		trunc <= '0';
        		seq <= '0';
        		done <= '0';
			
		when s_cycle1 =>
			nextstate <= s_cycle2;
			sel_reg1 <= "110"; --Q10
			sel_reg2 <= "110"; --Q00
			sel_reg3 <= "101"; --x
			sel_reg4 <= "101"; --x0
			sel_reg5 <= "XX";
			sel_reg6 <= "XX";
			sel_out1 <= "00"; --saves the result of adder1 in R1
			sel_out2 <= "01"; --saves the result of adder2 in R2
			sel_out3 <= "XX";
			sel_out4 <= "XX";
			load <= "0011";  -- enable of R1 and R2
			sel_add  <= "11"; -- 2 subtractions
			trunc <= '0'; 
			seq <= '0';
			done <= '0';
		
		when s_cycle2 =>
			nextstate <= s_cycle3;
			sel_reg1 <= "100"; --y
			sel_reg2 <= "100"; --y0
			sel_reg3 <= "111"; --Q11
			sel_reg4 <= "111"; --Q01
			sel_reg5 <= "00"; --R1
			sel_reg6 <= "01"; --R2
			sel_out1 <= "00" ; --saves the result of adder1
			sel_out2 <= "XX";
			sel_out3 <= "01" ; --saves the result of adder2
			sel_out4 <= "10" ; --saves the result of mult
			load <= "1101"; --enable of R3, R4 and R1
			sel_add  <= "11"; --subtraction in adder1
			trunc <= '1'; -- truncate the result of mult 
			seq <= '0';
			done <= '0';
			
		
		when s_cycle3 =>
			nextstate <= s_cycle4;
			sel_reg1 <= "011"; --R4
			sel_reg2 <= "110"; --Q00 
			sel_reg3 <= "XXX"; --not used
			sel_reg4 <= "XXX"; --not used
			sel_reg5 <= "10"; --R3
			sel_reg6 <= "01"; --R2
			sel_out1 <= "XX";
			sel_out2 <= "00"; --saves the result of adder1 
			sel_out3 <= "XX";
			sel_out4 <= "10"; --saves the result of mult
			load <= "1010"; 
			sel_add  <= "X0"; --add in adder1
			trunc <= '1'; -- truncates the mult result
			done <= '0';
			seq <= '0';
		when s_cycle4 =>
			nextstate <= s_cycle5;
			sel_reg1 <= "011"; --R4
			sel_reg2 <= "111"; --Q01 
			sel_reg3 <= "010"; -- R2
			sel_reg4 <= "001"; -- R3
			sel_reg5 <= "XX"; --not used
			sel_reg6 <= "XX"; --not used
			sel_out1 <= "XX";
			sel_out2 <= "XX";
			sel_out3 <= "00"; --saves the result of adder1 
			sel_out4 <= "01"; --saves the result of adder2
			load <= "1100"; 
			sel_add  <= "10"; --add in adder1 and sub in adder 2
			trunc <= '0';
			seq <= '1';
			done <= '0';
		
		when s_cycle5 =>
			nextstate <= s_cycle6;	
			sel_reg1 <= "XXX"; --not used
			sel_reg2 <= "XXX"; --not used
			sel_reg3 <= "XXX"; --not used
			sel_reg4 <= "XXX"; --not used
			sel_reg5 <= "11"; --R4
			sel_reg6 <= "00"; --R1
			sel_out1 <= "XX";
			sel_out2 <= "XX";
			sel_out3 <= "10"; --saves the result of the mult
			sel_out4 <= "XX";
			load <= "0100"; 
			sel_add  <= "XX"; 
			done <= '0';
			trunc <= '1'; -- truncates the mult result
			seq <= '0';
			
		
		when s_cycle6 =>
			nextstate <= s_end;
			sel_reg1 <= "010"; --R3
			sel_reg2 <= "001"; --R2
			sel_reg3 <= "XXX"; --not used
			sel_reg4 <= "XXX"; --not used
			sel_reg5 <= "XX"; --not used
			sel_reg6 <= "XX"; --not used
			sel_out1 <= "XX";
			sel_out2 <= "XX";
			sel_out3 <= "XX";
			sel_out4 <= "00"; --saves the result of adder1
			load <= "1000"; 
			sel_add  <= "X0"; --add in adder1
			trunc <= '0';
			seq <= '0';
			done <= '0'; 

			
		when s_end =>
			nextstate <= s_initial;
			load <="0000";
			sel_reg1 <= "XXX";
			sel_reg2 <= "XXX";
			sel_reg3 <= "XXX";
			sel_reg4 <= "XXX";
			sel_reg5 <= "XX";
			sel_reg6 <= "XX";
			sel_out1 <= "XX";
			sel_out2 <= "XX";
			sel_out3 <= "XX";
			sel_out4 <= "XX";
			sel_add <= "XX";
			trunc <= '0';
			seq <= '0';
			done <= '1';
	 end case;
 end process;
end Behavioral;
