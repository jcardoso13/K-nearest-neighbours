library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity datapath2 is
port(
    clk,rst: in std_logic;
    load : in std_logic_vector(1 downto 0); -- the MSB is for datapath1 enable and the other is for datapath2 enable
    valid : in std_logic; --valid for the datapath1
	A: in unsigned(31 downto 0);
	
	class: in std_logic_vector(1 downto 0);
    reg1,reg2,reg3,reg4,reg0: out std_logic_vector(31 downto 0);
   class1,class2,class3,class4,class0: out std_logic_vector(1 downto 0);
   valid_out: out std_logic
	);
end datapath2;


architecture Behavioral of datapath2 is


signal lowest,lowest_buff: unsigned(4 downto 0);
signal reg4_value,reg3_value,reg2_value,reg1_value,reg0_value: std_logic_vector(31 downto 0);
signal reg4_class,reg3_class,reg2_class,reg1_class,reg0_class: std_logic_vector(1 downto 0);
begin

lowest_buff(4) <= '1' when unsigned(A) < unsigned(reg4_value) else '0';
lowest_buff(3) <= '1' when unsigned(A) < unsigned(reg3_value) else '0';
lowest_buff(2) <= '1' when unsigned(A) < unsigned(reg2_value) else '0';
lowest_buff(1) <= '1' when unsigned(A) < unsigned(reg1_value) else '0';
lowest_buff(0) <= '1' when unsigned(A) < unsigned(reg0_value) else '0';


lowest<= lowest_buff when valid='1' else (others=>'0');

 process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 reg1_value <= (others => '1');
 reg1_class <= "11";
  elsif lowest(2 downto 1)="11" then
 reg1_value <=reg2_value;
 reg1_class <= reg2_class;
 elsif lowest(2 downto 1)="01" then
 reg1_value <= std_logic_vector(A);
 reg1_class <= class;
 end if;
 end if;
 end process;
 
 process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 reg2_value <= (others => '1');
 reg2_class <= "11";
 elsif lowest(3 downto 2)="11" then
 reg2_value <=reg3_value;
 reg2_class <= reg3_class;
 elsif lowest(3 downto 2)="01" then
 reg2_value <= std_logic_vector(A);
 reg2_class <= class;
 end if;
 end if;
 end process;
 
  process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 reg3_value <= (others => '1');
 reg3_class <= "11";
 elsif lowest(4 downto 3)="11" then
 reg3_value <=reg4_value;
 reg3_class <= reg4_class;
 elsif lowest(4 downto 3)="01" then
 reg3_value <= std_logic_vector(A);
 reg3_class <= class;
 end if;
 end if;
 end process;
 
 
 
 process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 reg4_value <= (others => '1');
 reg4_class <= "11";
 elsif lowest(4)='1' then
 reg4_value <= std_logic_vector(A);
 reg4_class <= class;
 end if;
 end if;
 end process;
 
 


 process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 reg0_value <= (others => '1');
 reg0_class <= "11";
  elsif lowest(1 downto 0)="11" then
 reg0_value <=reg1_value;
 reg0_class <= reg1_class;
 elsif lowest(4 downto 3)="01" then
 reg0_value <= std_logic_vector(A);
 reg0_class <= class;
 end if;
 end if;
 end process;
 
 
 reg1<=reg1_value;
 class1<=reg1_class;
 
 reg2<=reg2_value;
 class2<=reg2_class;
 
 reg3<=reg3_value;
 class3<=reg3_class;
 
 reg4<=reg4_value;
 class4<=reg4_class;
 
 reg0<=reg0_value;
 class0<=reg0_class;
 
valid_out <= valid;

end Behavioral;
