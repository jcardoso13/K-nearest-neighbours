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
        clk: in std_logic; 
        rst: in std_logic;
        init: in std_logic;
        new_instance: in std_logic_vector(63 downto 0);
        k: in std_logic_vector(1 downto 0);
        option: in std_logic;
        result: out std_logic_vector(1 downto 0)
    );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
	signal init: std_logic := '0';
	signal new_instance: std_logic_vector(63 downto 0) 
	:=x"DCCC63339CCC3000";
	signal k: std_logic_vector(1 downto 0):="10";
	signal option: std_logic:='1';

 	--Outputs
 	signal result:std_logic_vector(1 downto 0):= (others => '0');
   -- Clock period definitions
   constant clk_period : time := 10.00 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: circuit port map(
      clk => clk,
      rst => rst,
      init => init,
      new_instance => new_instance,
      k=> k,
      option=>option,
      result => result
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
		rst <= '0';
		wait for 30 ns;
		init <= '1';
        wait for 30 ns;
        init <= '0';     
       
	  
	 

      wait;
   end process;

END;
