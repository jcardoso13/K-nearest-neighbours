--Training Memory with Counter, outputs both operands


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mem is
port(
    clk,rst: in std_logic;
	init: in std_logic;
	data_out: out std_logic_vector(15 downto 0);
	valid: out std_logic -- to enter in the datapath1
	);
end mem;

architecture Behavioral of mem is


component design_1_blk_mem_gen_0_1 is
  Port ( 
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 8 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 15 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 15 downto 0 );
    clkb : in STD_LOGIC;
    web : in STD_LOGIC_VECTOR ( 0 to 0 );
    addrb : in STD_LOGIC_VECTOR ( 8 downto 0 );
    dinb : in STD_LOGIC_VECTOR ( 15 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
end component;

-- DEFINE mem instance here
signal data_b: std_logic_vector(15 downto 0); --Q3.13;
signal addr: unsigned(15 downto 0);

begin



training_mem:design_1_blk_mem_gen_0_1 port map(
addra => std_logic_vector(addr),
addrb => (others => '0'),
wea => (others => '0'),
clka => clk,
clkb => clk,
web => (others => '0'),
dina => (others => '0'),
dinb => (others => '0'),
douta => data_out,
doutb => data_b
);
process (clk)
 begin
 if clk'event and clk='1' then
	if rst='1' then
		addr <= "0000000";
	elsif init='1' then
		addr <= addr+1;
 end if;
 end if;
 end process;

end Behavioral;
