LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
 
ENTITY circuit_tb IS
END circuit_tb;
 
ARCHITECTURE behavior OF circuit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT circuit
    port(
clk, rst: in std_logic;
	reg_input_x,reg_input_y,
	reg_input_x0,reg_input_y0: in signed(8 downto 0);
	
	reg_input_Q00,reg_input_Q01,
	reg_input_Q10,reg_input_Q11: in signed(9 downto 0);
	output: out std_logic_vector(9 downto 0)
);
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal reg_input_x,reg_input_y,
       reg_input_x0,reg_input_y0: signed(8 downto 0) :=b"000000000";
       
   signal  reg_input_Q00,reg_input_Q01,
       reg_input_Q10,reg_input_Q11: signed(9 downto 0) :=b"0000000000";


 	--Outputs
 	signal output:std_logic_vector(9 downto 0):= (others => '0');
   -- Clock period definitions
   constant clk_period : time := 7.25 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: circuit port map(
      clk => clk,
      rst => rst,
      reg_input_x=>reg_input_x,
      reg_input_y=>reg_input_y,
      reg_input_x0=>reg_input_x0,
      reg_input_y0=>reg_input_y0,
      reg_input_Q00=>reg_input_Q00,
      reg_input_Q01=>reg_input_Q01,
      reg_input_Q10=>reg_input_Q10,
      reg_input_Q11=>reg_input_Q11,
      output => output
        );

   -- Clock definition
   clk <= not clk after clk_period/2;

    -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      rst<='1';
      wait for 100 ns;
     	
      --Case 1--
      
	 -- reg_input_x <= b"000100000" after clk_period; --32
	 -- reg_input_y <= b"000100000" after clk_period; --32
	 -- reg_input_y0 <= b"000000000" after clk_period; -- 0
	  --reg_input_x0 <= b"000000000" after clk_period; -- 0
	  --reg_input_Q00 <= b"1000000000" after clk_period; -- -512
	  --reg_input_Q01 <= b"0000000000" after clk_period; --0
	 -- reg_input_Q10 <= b"0111111111" after clk_period; -- 511
	  --reg_input_Q11 <= b"0000000000" after clk_period; --0
	  
	  --Case 2--
	  
	   -- reg_input_x <= b"000010000" after clk_period; --16
       -- reg_input_y <= b"000010000" after clk_period; --16
       -- reg_input_y0 <= b"000000000" after clk_period; -- 0
       -- reg_input_x0 <= b"000000000" after clk_period; -- 0
       -- reg_input_Q00 <= b"1000000000" after clk_period; -- -512
       -- reg_input_Q01 <= b"0000000000" after clk_period; --0
       -- reg_input_Q10 <= b"0111111111" after clk_period; -- 511
       -- reg_input_Q11 <= b"0000000000" after clk_period; --0
       
       --Case 3--
       
      -- reg_input_x <= b"000010000" after clk_period; --16
      -- reg_input_y <= b"000100000" after clk_period; --32
      -- reg_input_y0 <= b"000000000" after clk_period; -- 0
      -- reg_input_x0 <= b"000000000" after clk_period; -- 0
      -- reg_input_Q00 <= b"0000010000" after clk_period; -- 16
      -- reg_input_Q01 <= b"0000000000" after clk_period; --0
     --  reg_input_Q10 <= b"0000100000" after clk_period; -- 32
      -- reg_input_Q11 <= b"0000100000" after clk_period; --32
       
       --Case 4
       
        reg_input_x <= b"000010000" after clk_period; --16
        reg_input_y <= b"000100000" after clk_period; --32
        reg_input_y0 <= b"000000000" after clk_period; -- 0
        reg_input_x0 <= b"000000000" after clk_period; -- 0
        reg_input_Q00 <= b"0000000000" after clk_period; -- 0
        reg_input_Q01 <= b"0000010000" after clk_period; --16
        reg_input_Q10 <= b"0000100000" after clk_period; -- 32
        reg_input_Q11 <= b"0000100000" after clk_period; --32
              
       
	  
	  
	  rst <= '0' after clk_period*4,
	          '1' after clk_period*100;
	  
	 

      wait;
   end process;

END;
