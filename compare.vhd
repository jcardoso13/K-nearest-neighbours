library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity compare is
port(

    clk,rst: in std_logic;
	--Reg1 to Reg5 and Reg6 to Reg10
    reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10: in std_logic_vector(31 downto 0);
	class1, class2, class3, class4, class5, class6, class7, class8, class9, class10: in std_logic_vector(1 downto 0);
	
	regout1, regout2, regout3, regout4, regout5: out std_logic_vector(31 downto 0);
	classout1, classout2, classout3, classout4, classout5: out std_logic_vector(1 downto 0)
	
	);
end compare;


architecture Behavioral of compare is

	signal accum5: std_logic_vector(31 downto 0);
	signal class_accum5: std_logic_vector(1 downto 0);
	
	signal aux_reg4, accum4_1, accum4_2 : std_logic_vector(31 downto 0);
	signal class_aux4, class_accum4_1, class_accum4_2: std_logic_vector(1 downto 0);
	
	signal aux_reg3_1, aux_reg3_2, accum3_1, accum3_2, accum3_3: std_logic_vector (31 downto 0);
	signal class_aux3_1, class_aux3_2, class_accum3_1, class_accum3_2, class_accum3_3 : std_logic_vector(1 downto 0);
	
	signal aux_reg2_1, aux_reg2_2, aux_reg2_3, accum2_1, accum2_2, accum2_3, accum2_4: std_logic_vector(31 downto 0);
	signal class_aux2_1, class_aux2_2, class_aux2_3, class_accum2_1, class_accum2_2, class_accum2_3, class_accum2_4: std_logic_vector(1 downto 0);
	
	signal aux_reg1_1, aux_reg1_2, aux_reg1_3, aux_reg1_4: std_logic_vector(31 downto 0);
	signal class_aux1_1, class_aux1_2, class_aux1_3, class_aux1_4: std_logic_vector(1 downto 0);
	

	begin
	process(reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, class1, class2, class3, class4, class5, class6, class7, class8, class9, class10)
	begin

	if reg10>reg5 then
		regout5 <= reg5;
		classout5 <= class5;
		accum5 <= reg10;
		class_accum5 <= class10;
	else 
		regout5 <= reg10;
		classout5 <= class10;
		accum5 <= reg5;
		class_accum5 <= class5;
	end if;		
	
	if reg9 > reg4 then 
		aux_reg4 <= reg4;
		class_aux4 <= class4;
		accum4_1 <= reg9;
		class_accum4_1 <= class9;
	else
		aux_reg4 <= reg9;
		class_aux4 <= class9;
		accum4_1 <= reg4;
		class_accum4_1 <= class4;
	end if;
	
	if accum5 > aux_reg4 then
		regout4 <= aux_reg4;
		classout4 <= class_aux4;
		accum4_2 <= accum5;
		class_accum4_2 <= class_accum5;
	else 
		regout4 <= accum5;
		classout4 <= class_accum5;
		accum4_2 <= aux_reg4;
		class_accum4_2 <= class_aux4;
	end if;
	
	if reg8 > reg3 then 
		aux_reg3_1 <= reg3;
		class_aux3_1 <= class3;
		accum3_1 <= reg8;
		class_accum3_1 <= class8;
	else
		aux_reg3_1 <= reg8;
		class_aux3_1 <= class8;
		accum3_1 <= reg3;
		class_accum3_1 <= class3;
	end if;
	
	if accum4_1 > aux_reg3_1 then	
		aux_reg3_2 <= aux_reg3_1;
		class_aux3_2 <= class_aux3_1;
		accum3_2 <= accum4_1;
		class_accum3_2 <= class_accum4_1;
	else
		aux_reg3_2 <= accum4_1;
		class_aux3_2 <= class_accum4_1;
		accum3_2 <= aux_reg3_1;
		class_accum3_2 <= class_aux3_1;
	end if;
	
	if accum4_2 > aux_reg3_2 then
		regout3 <= aux_reg3_2;
		classout3 <= class_aux3_2;
		accum3_3 <= accum4_2;
		class_accum3_3 <= class_accum4_2;
	else
		regout3 <= accum4_2;
		classout3 <= class_accum4_2;
		accum3_3 <= aux_reg3_2;
		class_accum3_3 <= class_aux3_2;
	end if;
	
	if reg7 > reg2 then
		aux_reg2_1 <= reg2;
		class_aux2_1 <= class2;
		accum2_1 <= reg7;
		class_accum2_1 <= class7;
	else
		aux_reg2_1 <= reg7;
		class_aux2_1 <= class7;
		accum2_1 <= reg2;
		class_accum2_1 <= class2;
	end if;
	
	if accum3_1 > aux_reg2_1 then
		aux_reg2_2 <= aux_reg2_1;
		class_aux2_2 <= class_accum2_1;
		accum2_2 <= accum3_1;
		class_accum2_2 <= class_accum3_1;
	else
		aux_reg2_2 <= accum3_1;
		class_aux2_2 <= class_accum3_1;
		accum2_2 <= aux_reg2_1;
		class_accum2_2 <= class_accum2_1;
	end if;
		
	if accum3_2 > aux_reg2_2 then
		aux_reg2_3 <= aux_reg2_2;
		class_aux2_3 <= class_accum2_2;
		accum2_3 <= accum3_2;
		class_accum2_3 <= class_accum3_2;
	else
		aux_reg2_3 <= accum3_2;
		class_aux2_3 <= class_accum3_2;
		accum2_3 <= aux_reg2_2;
		class_accum2_3 <= class_accum2_2;
	end if;
	
	if accum3_3 > aux_reg2_3 then
		regout2 <= aux_reg2_3;
		classout2 <= class_accum2_3;
		accum2_4 <= accum3_3;
		class_accum2_4 <= class_accum3_3;
	else
		regout2 <= accum3_3;
		classout2 <= class_accum3_3;
		accum2_4 <= aux_reg2_3;
		class_accum2_4 <= class_accum2_3;
	end if;
	
	if reg6 > reg1 then 
		aux_reg1_1 <= reg1;
		class_aux1_1 <= class1;
	else 
		aux_reg1_1 <= reg6;
		class_aux1_1 <= class6;
	end if;
	
	if accum2_1 > aux_reg1_1 then
		aux_reg1_2 <= aux_reg1_1;
		class_aux1_2 <= class_aux1_1;
	else 
		aux_reg1_2 <= accum2_1;
		class_aux1_2 <= class_accum2_1;
	end if;
	
	if accum2_2 > aux_reg1_2 then
		aux_reg1_3 <= aux_reg1_2;
		class_aux1_3 <= class_aux1_2;
	else
		aux_reg1_3 <= accum2_2;
		class_aux1_3 <= class_accum2_2;
	end if;
	
	if accum2_3 > aux_reg1_3 then 
		aux_reg1_4 <= aux_reg1_3;
		class_aux1_4 <= class_aux1_3;
	else
		aux_reg1_4 <= accum2_3;
		class_aux1_4 <= class_accum2_3;
	end if;
	
	if accum2_4 > aux_reg1_4 then 
		regout1 <= aux_reg1_4;
		classout1 <= class_aux1_4;
	else 
		regout1 <= accum2_4;
		classout1 <= class_accum2_4;
	end if; 
	
	end process; 
	
end Behavioral;
