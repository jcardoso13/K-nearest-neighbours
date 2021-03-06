--Training Memory with Counter, outputs both operands


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mem is
port(
    clk,rst: in std_logic;
	init: in std_logic;
	data_out: out std_logic_vector(1151 downto 0);
	class_out : out std_logic_vector(1 downto 0);
	valid: out std_logic -- to enter in the datapath1
	);
end mem;

architecture Behavioral of mem is


component blk_mem_gen_0 is
    Port ( 
    clka : in STD_LOGIC;
    addra : in STD_LOGIC_VECTOR ( 2 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 1151 downto 0 )
  );
  end component;

component dist_mem_gen_0 is
 Port ( 
    a : in STD_LOGIC_VECTOR ( 3 downto 0 );
    d : in STD_LOGIC_VECTOR ( 1 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    qspo : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component;

-- DEFINE mem instance here
signal data_b: std_logic_vector(1151 downto 0); --Q3.13;
signal addr: unsigned(2 downto 0);
signal addr_class: unsigned(3 downto 0);
--signal addr_class: unsigned(6 downto 0);

begin



training_mem:blk_mem_gen_0 port map(
addra=> std_logic_vector(addr),
clka => clk,
douta => data_out
);

training_mem_classes: dist_mem_gen_0 port map(
clk => clk,
we => '0',
qspo => class_out,
d => (others => '0'),
a => std_logic_vector(addr_class)
);

process (clk)
 begin
 if clk'event and clk='1' then
	if rst='1' then
		addr <= "000";
		valid<='0';
		addr_class<="1111";
	elsif (init='1' and addr=0) then
		addr <= addr+1;
		addr_class<=addr_class+1;
		valid<='0';
	elsif(addr=1) then
	   addr <= addr+1;
	   addr_class<=addr_class+1;
	   valid<='1';
	elsif(addr>1 and addr<6) then
	     addr <= addr+1;
         addr_class<=addr_class+1;
         valid <='1';
	elsif (addr_class<6 and addr_class>0) then
	   addr_class<=addr_class+1;
	   valid<='1';
	else
	   valid<='0';
 end if;
 end if;
 end process;
 
--addr_class<=addr-3;
 
 
--process (clk)
--  begin
--  if clk'event and clk='1' then
--     if rst='1' then
--         addr_class <= "0000000";
--     elsif addr>3 and addr<111 then
--         addr_class <= addr_class+1;
--     else
--     addr_class <= "0000000";
--  end if;
--  end if;
--  end process;
 
 

end Behavioral;
