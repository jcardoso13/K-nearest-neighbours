--Training Memory with Counter, outputs both operands


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mem is
port(
    clk,rst,load: in std_logic;
	operand: in unsigned(15 downto 0);
	init: in std_logic;
	data_out: out std_logic_vector(15 downto 0)
	);
end mem;


architecture Behavioral of mem is

type memRAM is array(0 to 107) of std_logic_vector(15 downto 0);
signal instance_mem: memRAM;
-- DEFINE mem instance here
signal data_out: std_logic_vector(15 downto 0); --Q3.13

begin

data_out <= instance_mem(Counter);

process (clk)
 begin
 if clk'event and clk='1' then
	if rst='1' then
		Counter <= "0000000";
	elsif init='1' then
		Counter <= Counter+1;
 end if;
 end if;
 end process;

end Behavioral;
