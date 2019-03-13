library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fpga_basicIO is
  port (
    clk: in std_logic;                            -- 100MHz clock
    btnC, btnU, btnL, btnR, btnD: in std_logic;   -- buttons
    sw: in std_logic_vector(15 downto 0);         -- switches
    led: out std_logic_vector(15 downto 0);       -- leds
    an: out std_logic_vector(3 downto 0);         -- display selectors
    seg: out std_logic_vector(6 downto 0);        -- display 7-segments
    dp: out std_logic                             -- display point
  );
end fpga_basicIO;

architecture Behavioral of fpga_basicIO is
  signal dd0 : std_logic_vector(6 downto 0);
  signal res : std_logic_vector(1 downto 0);
  signal dact : std_logic_vector(3 downto 0);
  signal btnRinstr : std_logic_vector(3 downto 0);
  signal clk10hz, clk_disp : std_logic;
  signal btnCreg, btnUreg, btnLreg, btnRreg, btnDreg: std_logic;   -- registered input buttons
  signal sw_reg : std_logic_vector(15 downto 0);  -- registered input switches
  signal tdisp : std_logic_vector(15 downto 0); -- Output to Display
 -- signal dp_value: std_logic;
  signal reg_value: std_logic_vector(12 downto 0);

  signal aux_value: std_logic_vector(16 downto 0);
  signal reg4,reg3,reg2,reg1: std_logic_vector(15 downto 0);
  signal data_in: std_logic_vector(63 downto 0);
  signal k_new: std_logic_vector(1 downto 0);
  signal result_ready: std_logic;
  component disp7
  port (
   disp3, disp2, disp1, disp0 : in std_logic_vector(6 downto 0);
   dp3, dp2, dp1, dp0 : in std_logic;
   dclk : in std_logic;
   dactive : in std_logic_vector(3 downto 0);
   en_disp_l : out std_logic_vector(3 downto 0);
   segm_l : out std_logic_vector(6 downto 0);
   dp_l : out std_logic);
  end component;
  component hex2disp
    port (
      sw : in std_logic_vector(3 downto 0);
      seg : out std_logic_vector(6 downto 0)
      );
  end component;
  component clkdiv
    port(
      clk100M : in std_logic;          
      clk10Hz : out std_logic;
      clk_disp : out std_logic);
  end component;
  component circuit
    port(
        clk: in std_logic; 
		rst: in std_logic;
		init: in std_logic;
		option: in std_logic;
		new_instance: in std_logic_vector(63 downto 0);
		k: in std_logic_vector(1 downto 0);
		result: out std_logic_vector(1 downto 0);
		result_ready: out std_logic
      );
  end component;

begin
  led <= sw_reg;

    
  dact <= "1111";

  inst_disp7: disp7 port map(
      disp3 => (others => '0') , disp2 =>(others => '0'), disp1 => (others => '0'), disp0 => dd0,
      dp3 => '0', dp2 => '0', dp1 => '0', dp0 => '0',  
      dclk => clk_disp,
      dactive => dact,
      en_disp_l => an,
      segm_l => seg,
      dp_l => dp);


tdisp(3 downto 0) <= "00"&res;

tdisp(15 downto 4) <= (others => '0');

  inst_hex0: hex2disp port map(sw => tdisp(3 downto 0), seg => dd0);
  
  
  inst_clkdiv: clkdiv port map(
    clk100M => clk,
    clk10hz => clk10hz,
    clk_disp => clk_disp); 

  inst_circuit: circuit port map(
      clk => clk,
      rst => sw_reg(0),
      init  => btnRreg,
      option => btnLreg,
      new_instance =>data_in,
      k=>k_new,
      result => res,
      result_ready => result_ready
      );
      
     

                          
     
        process (clk10hz)
     begin
     if rising_edge(clk10hz) then
        btnCreg <= btnC; btnUreg <= btnU; btnLreg <= btnL; 
        btnRreg <= btnR; btnDreg <= btnD;
        sw_reg <= sw;
       -- 
         if(btnLreg='1') then
                    reg1<=reg2;
                    reg2<=reg3;
                    reg3<=reg4;
                    reg4<=sw_reg(15 downto 0);
                   
               elsif (btnDreg='1') then
                   k_new<="00";      
               elsif(btnUreg='1') then
                   k_new <="10";     
               elsif(btnCreg='1') then
                   k_new <="01";     
               end if;
    end if;    
  end process;
  data_in <=  reg4 & reg3 & reg2 & reg1;
  --data_in <=x"A33300072CCC0666";    
    
end Behavioral;
