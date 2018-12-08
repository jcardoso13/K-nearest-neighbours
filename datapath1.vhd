library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath1 is
port(
	-- INPUTS
    clk: in std_logic;
    rst: in std_logic;
	A_in: in unsigned(63 downto 0);
	B_in: in unsigned(63 downto 0);
    load: in std_logic_vector(1 downto 0); -- enable result --
	valid: in std_logic; -- valid inputs --
	
	-- OUTPUTS
	
    C: out signed(33 downto 0) -- Q8.26 --
	valid_result: out std_logic; -- TO THE DATAPATH 2 
	
	
);
end datapath1;


architecture Behavioral of datapath1 is

component adder 
	port(
	A: in unsigned(31 downto 0); -- Q6.26 --
	B: in unsigned(31 downto 0); -- Q6.26 --
	C: out unsigned(31 downto 0) -- Q6.26 --
	
);
end component;

component subtractor
	port(
	A: in unsigned(16 downto 0); -- Q4.13 --
	B: in unsigned(16 downto 0); -- Q4.13 -- 
	C: out unsigned(16 downto 0) -- Q4.13 --
	
);
end component;

component mult 
	port(
	A:in signed(16 downto 0); -- Q4.13 --
	B:in signed(16 downto 0); -- Q4.13 --
	C: out signed(33 downto 0) -- Q8.26 --
);
end component; 

--SIGNALS

signal A1, A2, A3, A4: signed(16 downto 0);
signal B1, B2, B2, B4: signed(16 downto 0);
signal valid_sub, valid_mult, valid_add, valid_result;
signal output_sub1, output_sub2, output_sub3, output_sub4: signed(16 downto 0);
signal out_sub1, out_sub2, out_sub3, out_sub4 : signed (16 downto 0);
signal output_mult1, output_mult2, output_mult3, output_mult4: signed (33 downto 0);
signal out_mult1, out_mult2, out_mult3, out_mult4: signed (33 downto 0);
signal output_adder1, output_adder2, output_adder3: signed( 33 downto 0);
signal out_adder1, out_adder2: signed( 33 downto 0);

begin


inst_sub1: subtractor portmap(
A => A_in(15) & A_in(15 downto 0);
B => B_in(15) & B_in(15 downto 0);
C => output_sub1
);

inst_sub2: subtractor portmap(
A => A_in(31) & A_in(31 downto 16);
B => B_in(31) & B_in(31 downto 16);
C => output_sub2
);

inst_sub3: subtractor portmap(
A => A_in(47) & A_in(47 downto 32);
B => B_in(47) & B_in(47 downto 32);
C => output_sub3
);

inst_sub4: subtractor portmap(
A => A_in(63) & A_in(63 downto 48);
B => B_in(63) & B_in(63 downto 48);
C=> output_sub4
);

inst_mult1: mult portmap(
A=> out_sub1,
B=> out_sub1,
C=> output_mult1
);

inst_mult2: mult portmap(
A=> out_sub2,
B=> out_sub2,
C=> output_mult2
);

inst_mult3: mult portmap(
A=> out_sub3,
B=> out_sub3,
C=> out_mult3
);

inst_mult4: mult portmap(
A=> out_sub4,
B=> out_sub4,
C=> output_mult4
);

inst_adder1: adder portmap(
A=> out_mult1(31 downto 0),
B=> out_mult2(31 downto 0),
C=> output_adder1
);

inst_adder2: adder portmap(
A=> out_mult3(31 downto 0),
B=> out_mult4(31 downto 0),
C=> output_adder2
);

inst_adder3: adder portmap(
A => out_adder1,
B=> out_adder2,
C=> output_adder3
);



 
 -- ADD1 AND ADD2 RESULTS SAVED IN THE REGISTERS WHEN THE MULTIPLICATION RESULTS ARE VALID
 
 process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 out_adder1 <= (others => '0');
 out_adder2 <= (others => '0');


 elsif (load(1) = '1' && valid_mult = '1') then -- Se a instancia for diferente da submetida anteriormente entao carrega no registo de saida, o resultado os calculos efetuados 

 out_adder1 <= output_adder1;
 out_adder2 <= output_adder2;
 valid_add <= valid_mult;

 
 end if;
 end if;
 end process;
 
 --MULT RESULTS SAVED IN THE REGISTERS WHEN THE SUBTRACTION RESULTS ARE VALID
   process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 out_mult1 <= (others => '0');
 out_mult2 <= (others => '0');
 out_mult3 <= (others => '0');
 out_mult4 <= (others => '0');
 
 elsif (load(1) ='1' && valid_sub = '1') then -- Se a instancia for diferente da submetida anteriormente entao carrega no registo de saida, o resultado os calculos efetuados 

 out_mult1 <= output_mult1;
 out_mult2 <= output_mult2;
 out_mult3 <= output_mult3;
 out_mult4 <= output_mult4;
 valid_mult <= valid_sub;
 
 end if;
 end if;
 end process;
 
--SUB RESULTS SAVED IN THE REGISTERS WHEN THE INPUTS A AND B ARE VALID

  process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 out_sub1 <= (others => '0');
 out_sub2 <= (others => '0');
 out_sub3 <= (others => '0');
 out_sub4 <= (others => '0');
 
 elsif (load(1) = '1' && valid = '1') then -- Se a instancia for diferente da submetida anteriormente entao carrega no registo de saida, o resultado os calculos efetuados 

 out_sub1 <= output_sub1;
 out_sub2 <= output_sub2;
 out_sub3 <= output_sub3;
 out_sub4 <= output_sub4;
 valid_sub <= valid;
 
 end if;
 end if;
 end process;
 
  
--OUTPUT RESULT SAVED IN THE REGISTER WHEN THE RESULT OF ADDER 1 AND  ADDER 2 IS VALID 
process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 C <= (others => '0');
 elsif (load(1) = '1' && valid_add = '1') then -- Se a instancia for diferente da submetida anteriormente entao carrega no registo de saida, o resultado os calculos efetuados 
 C <= output_adder3;
 valid_result <= valid_result;
 end if;
 end if;
 end process;

end Behavioral;
