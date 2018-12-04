library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath2 is
port(
    clk,rst,load: in std_logic;
	A: in signed(31 downto 0);
	k: in std_logic_vector(2 downto 0);
	class: in std_logic_vector(1 downto 0);
    result: out std_logic_vector(1 downto 0)
	);
end datapath2;


architecture Behavioral of datapath2 is


signal lowest: std_logic_vector(4 downto 0);
signal reg4_value,reg3_value,reg2_value,reg1_value,reg0_value: std_logic_vector(31 downto 0);
signal reg4_class,reg3_class,reg2_class,reg1_class,reg0_class: std_logic_vector(1 downto 0);

begin
lowest(4)<=A<reg4_value;
lowest(3)<= A<reg3_value;
lowest(2<= A<reg2_value;
lowest(1)<= A<reg1_value;
lowest(0)<= A<reg0_value;

process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 reg4_value <= (others => '1');
 reg4_class <= "11";
 elsif lowest(4)='1' then
 reg4_value <= A;
 reg4_class <= class;
 end if;
 end if;
 end process;

 process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 reg3_value <= (others => '1');
 reg3_class <= "11";
 elsif lowest(3)='1' then
 reg3_value <= A when lowest(4)='0' else reg4_value;
 reg3_class <= class when lowest(4)='0' else reg4_class;
 end if;
 end if;
 end process;

process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 reg2_value <= (others => '1');
 reg2_class <= "11";
 elsif lowest(2)='1' then
 reg2_value <= A when lowest(3)='0' else reg3_value;
 reg2_class <= class  when lowest(3)='0' else reg3_value;
 end if;
 end if;
 end process;

 process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 reg1_value <= (others => '1');
 reg1_class <= "11";
 elsif lowest(1)='1' then
 reg1_value <= A  when lowest(2)='0' else reg2_value;
 reg1_class <= class  when lowest(2)='0' else reg2_value;
 end if;
 end if;
 end process;

 process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 reg0_value <= (others => '1');
 reg0_class <= "11";
 elsif lowest(0)='1' then
 reg0_value <= A when lowest(1)='0' else reg1_value;
 reg0_class <= class  when lowest(1)='0' else reg1_value;
 end if;
 end if;
 end process;




end Behavioral;