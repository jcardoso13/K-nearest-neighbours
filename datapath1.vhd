library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath1 is
port(
	-- INPUTS
    clk: in std_logic;
    rst: in std_logic;
	A_in: in std_logic_vector(63 downto 0);
	B_in: in std_logic_vector(63 downto 0);
    load: in std_logic_vector(1 downto 0); -- enable result --
	valid: in std_logic; -- valid inputs --
	
	-- OUTPUTS
	
    C: out unsigned(31 downto 0); -- Q6.26 --
	valid_result: out std_logic -- TO THE DATAPATH 2 
	
	
);
end datapath1;


architecture Behavioral of datapath1 is

component adder 
	port(
	A: in signed(31 downto 0); -- Q6.26 --
	B: in signed(31 downto 0); -- Q6.26 --
	C: out signed(31 downto 0) -- Q6.26 --
	
);
end component;

component subtractor
	port(
	A: in signed (16 downto 0); -- Q4.13 --
	B: in signed(16 downto 0); -- Q4.13 -- 
	C: out signed(16 downto 0) -- Q4.13 --
	
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
signal B1, B2, B3, B4: signed(16 downto 0);
signal output_sub1, output_sub2, output_sub3, output_sub4: signed(16 downto 0);
signal out_sub1, out_sub2, out_sub3, out_sub4 : signed (16 downto 0);
signal output_mult1, output_mult2, output_mult3, output_mult4: signed (33 downto 0);
signal out_mult1, out_mult2, out_mult3, out_mult4: signed (33 downto 0);
signal output_adder1, output_adder2, output_adder3: signed( 31 downto 0);
signal aux_A3,aux_A2,aux_A1,aux_A0,aux_B3,aux_B2,aux_B1,aux_B0: signed(16 downto 0);
signal valid_buff1,valid_buff2: std_logic;
begin

aux_A3 <= signed(A_in(63) & A_in(63 downto 48));
aux_A2 <= signed(A_in(47) & A_in(47 downto 32));
aux_A1 <= signed(A_in(31) & A_in(31 downto 16));
aux_A0 <= signed(A_in(15) & A_in(15 downto 0));
aux_B0 <= signed(B_in(15) & B_in(15 downto 0));
aux_B1 <= signed(B_in(31) & B_in(31 downto 16));
aux_B2 <= signed(B_in(47) & B_in(47 downto 32));
aux_B3 <= signed(B_in(63) & B_in(63 downto 48));

inst_sub1: subtractor port map(
A =>aux_A0,
B => aux_B0,
C => output_sub1
);

inst_sub2: subtractor port map(
A => aux_A1,
B => aux_B1,
C => output_sub2
);

inst_sub3: subtractor port map(
A => aux_A2,
B => aux_B2,
C => output_sub3
);

inst_sub4: subtractor port map(
A => aux_A3,
B => aux_B3,
C=> output_sub4
);

inst_mult1: mult port map(
A=> out_sub1,
B=> out_sub1,
C=> output_mult1
);

inst_mult2: mult port map(
A=> out_sub2,
B=> out_sub2,
C=> output_mult2
);

inst_mult3: mult port map(
A=> out_sub3,
B=> out_sub3,
C=> output_mult3
);

inst_mult4: mult port map(
A=> out_sub4,
B=> out_sub4,
C=> output_mult4
);

inst_adder1: adder port map(
A=> out_mult1(31 downto 0),
B=> out_mult2(31 downto 0),
C=> output_adder1
);

inst_adder2: adder port map(
A=> out_mult3(31 downto 0),
B=> out_mult4(31 downto 0),
C=> output_adder2
);

inst_adder3: adder port map(
A => output_adder1,
B=> output_adder2,
C=> output_adder3
);

 process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 out_sub1 <= (others => '0');
 out_sub2 <= (others => '0');
 out_sub3 <= (others => '0');
 out_sub4 <= (others => '0');
 
elsif (load(1) ='1' and valid ='1') then

 out_sub1 <= output_sub1;
 out_sub2 <= output_sub2;
 out_sub3 <= output_sub3;
 out_sub4 <= output_sub4;
 valid_buff1 <=valid;
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
 
 elsif (load(1) ='1' and valid_buff1='1') then -- Se a instancia for diferente da submetida anteriormente entao carrega no registo de saida, o resultado os calculos efetuados 

 out_mult1 <= output_mult1;
 out_mult2 <= output_mult2;
 out_mult3 <= output_mult3;
 out_mult4 <= output_mult4;
  valid_buff2<=valid_buff1;
  
  else 
  out_mult1 <= (others => '0');
   out_mult2 <= (others => '0');
   out_mult3 <= (others => '0');
   out_mult4 <= (others => '0');
 
 end if;


 end if;
 end process;
 
--SUB RESULTS SAVED IN THE REGISTERS WHEN THE INPUTS A AND B ARE VALID

 
 process (clk)
 begin
  if clk'event and clk='1' then
 if (load="11" and valid_buff2='1') then 
	C <= unsigned(output_adder3);
	valid_result <= '1';
end if;
end if;
end process;
end Behavioral;
