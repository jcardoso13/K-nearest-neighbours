--Training Memory with Counter, outputs both operands


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mem is
port(
    clk,rst: in std_logic;
	init: in std_logic;
	class_out: out std_logic_vector(1 downto 0);
	data_out: out std_logic_vector(63 downto 0);
	valid: out std_logic -- to enter in the datapath1
	);
end mem;

architecture Behavioral of mem is


component design_1_wrapper is
    port (
    BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    BRAM_PORTA_0_clk : in STD_LOGIC;
    BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 63 downto 0 );
    BRAM_PORTB_0_addr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    BRAM_PORTB_0_clk : in STD_LOGIC;
    BRAM_PORTB_0_dout : out STD_LOGIC_VECTOR ( 63 downto 0 )
  );
end component;

component design_2_wrapper is
  port (
    A_clk : in STD_LOGIC;
    A_we : in STD_LOGIC_VECTOR ( 0 to 0 );
    A_addr : in STD_LOGIC_VECTOR ( 6 downto 0 );
    A_din : in STD_LOGIC_VECTOR ( 1 downto 0 );
    A_dout : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component;

-- DEFINE mem instance here
signal data_b: std_logic_vector(63 downto 0); --Q3.13;
signal addr: unsigned(6 downto 0);
signal addr_class: unsigned(6 downto 0);
signal class_out_aux: std_logic_vector(1 downto 0);

begin



training_mem:design_1_wrapper port map(
BRAM_PORTA_0_addr=> std_logic_vector(addr),
BRAM_PORTB_0_addr => (others => '0'),
BRAM_PORTA_0_clk => clk,
BRAM_PORTB_0_clk => clk,
BRAM_PORTA_0_dout => data_out,
BRAM_PORTB_0_dout => data_b
);

training_mem_classes: design_2_wrapper port map(
A_clk => clk,
A_we => (others => '0'),
A_din => (others => '0'),
A_dout => class_out_aux,
A_addr => std_logic_vector(addr_class)
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
 
 
 process (clk)
  begin
  if clk'event and clk='1' then
     if rst='1' then
         addr_class <= "0000000";
     elsif addr>3 then
         addr_class <= addr_class+1;
  end if;
  end if;
  end process;
 
 

end Behavioral;
