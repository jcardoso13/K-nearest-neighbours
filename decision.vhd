library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity decision is
port(
	--INPUT
    clk,rst: in std_logic;
	load : in std_logic_vector (1 downto 0);
	class: in std_logic_vector(1 downto 0);
	valid: in std_logic_vector(17 downto 0) ;
	k: in std_logic_vector(1 downto 0);
	A: in std_logic_vector(575 downto 0);
	done: out std_logic;
	--OUTPUT
	class_out : out std_logic_vector(1 downto 0)
	
	
	);
end decision;


architecture Behavioral of decision is

component datapath2 is
port(
    clk,rst: in std_logic;
    load : in std_logic_vector(1 downto 0); -- the MSB is for datapath1 enable and the other is for datapath2 enable
    valid : in std_logic; --valid for the datapath1
	A: in unsigned(31 downto 0);
	class: in std_logic_vector(1 downto 0);
	
	reg1, reg2, reg3, reg4, reg0: out std_logic_vector(31 downto 0);
	class1, class2, class3, class4, class0 : out std_logic_vector(1 downto 0);
	valid_out: out std_logic
	
	);
end component;
component compare is
port(

    clk,rst: in std_logic;
	--Reg1 to Reg5 and Reg6 to Reg10
    reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10: in std_logic_vector(31 downto 0);
	class1, class2, class3, class4, class5, class6, class7, class8, class9, class10: in std_logic_vector(1 downto 0);
	valid_in: in std_logic;
	
	regout1, regout2, regout3, regout4, regout5: out std_logic_vector(31 downto 0);
	classout1, classout2, classout3, classout4, classout5: out std_logic_vector(1 downto 0);
	valid_out: out std_logic
	
	);
end component;


	signal reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9, reg10, reg11, reg12, reg13, reg14, reg15, reg16,reg17,reg18,reg19,reg20,reg21,reg22,reg23,reg24,
	reg25,reg26,reg27,reg28,reg29,reg30,reg31,reg32,reg33,reg34,reg35,reg36,reg37,reg38,reg39,reg40,reg41,reg42,reg43,reg44,reg45,reg46,reg47,reg48,reg49,reg50,reg51,
	reg52,reg53,reg54,reg55,reg56,reg57,reg58,reg59,reg60,reg61,reg62,reg63,reg64,reg65,reg66,reg67,reg68,reg69,reg70,reg71,reg72,reg73,reg74,reg75,reg76,reg77,reg78,
	reg79,reg80,reg81,reg82,reg83,reg84,reg85,reg86,reg87,reg88,reg89,reg90 :std_logic_vector(31 downto 0);
	
	signal classout1, classout2, classout3, classout4, classout5, classout6, classout7, classout8, classout9, classout10, classout11, classout12 , classout13, classout14,
	classout15, classout16, classout17, classout18, classout19, classout20, classout21, classout22, classout23, classout24, classout25, classout26, classout27, classout28,
	classout29, classout30, classout31, classout32, classout33, classout34, classout35, classout36, classout37, classout38, classout39, classout40, classout41, classout42, 
	classout43, classout44, classout45, classout46, classout47, classout48, classout49, classout50, classout51, classout52, classout53,classout54,classout55, classout56, classout57,
	classout58, classout59, classout60, classout61, classout62, classout63, classout64, classout65, classout66, classout67,  classout68, classout69, classout70, classout71, classout72,
	classout73, classout74, classout75, classout76, classout77, classout78, classout79, classout80: std_logic_vector(1 downto 0);
	
	signal class1,class2,class3,class4,class5,class6,class7,class8,class9,class10,class11,class12,class13,class14,class15,class16,class17,class18,class19,class20,class21,class22,
	class23,class24,class25,class26,class27,class28,class29,class30,class31,class32,class33,class34,class35,class36,class37,class38,class39,class40,class41,class42,class43,class44,
	class45,class46,class47,class48,class49,class50,class51,class52,class53,class54,class55,class56,class57,class58,class59,class60,class61,class62,class63,class64,class65,class66,
	class67,class68,class69,class70,class71,class72,class73,class74,class75,class76,class77,class78,class79,class80,class81,class82,class83,class84,class85,class86,class87,class88,
	class89,class90: std_logic_vector(1 downto 0);
	signal regout1,regout2,regout3,regout4,regout5,regout6,regout7,regout8,regout9,regout10,regout11,regout12,regout13,regout14,regout15,regout16,regout17,regout18,regout19,regout20,
	regout21,regout22,regout23,regout24,regout25,regout26,regout27,regout28,regout29,regout30,regout31,regout32,regout33,regout34,regout35,regout36,regout37,regout38,regout39,regout40,
	regout41,regout42,regout43,regout44,regout45,regout46,regout47,regout48,regout49,regout50,regout51,regout52,regout53,regout54,regout55,regout56,regout57,regout58,regout59,regout60,
	regout61,regout62,regout63,regout64,regout65,regout66,regout67,regout68,regout69,regout70,regout71,regout72,regout73,regout74,regout75,regout76,regout77,regout78,
	regout79,regout80: std_logic_vector(31 downto 0);
	
	signal final1,final2,final3,final4,final0: std_logic_vector(31 downto 0);
	signal finalclass1,finalclass2,finalclass3,finalclass4,finalclass0: std_logic_vector(1 downto 0);
	signal valid_out: std_logic_vector(17 downto 0);
	signal valid_in: std_logic_vector(8 downto 0);
	signal valid_data2: std_logic_vector(9 downto 0);
	signal valid2: std_logic_vector(15 downto 0);
	
	signal count2,count1,count0: unsigned(2 downto 0);
	signal k_calc_reg4_0,k_calc_reg4_1,k_calc_reg4_2: std_logic_vector(0 downto 0);
	signal k_calc_reg3_0,k_calc_reg3_1,k_calc_reg3_2: std_logic_vector(0 downto 0);
	signal k_calc_reg2_0,k_calc_reg2_1,k_calc_reg2_2: std_logic_vector(0 downto 0);
	signal k_calc_reg1_0,k_calc_reg1_1,k_calc_reg1_2: std_logic_vector(0 downto 0);
	signal k_calc_reg0_0,k_calc_reg0_1,k_calc_reg0_2: std_logic_vector(0 downto 0);
	signal aux0:std_logic_vector(1 downto 0);
	signal prev_valid: std_logic;
	signal class_out_aux: std_logic_vector(1 downto 0);
	
	signal out_data: unsigned(575 downto 0);
	
	begin
	
	out_data <= unsigned(A);
inst_datapath2_1: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(0),
	A => out_data(31 downto 0),
	class => class,
	reg0 => reg1, 
	reg1 => reg2,
	reg2 => reg3, 
	reg3 => reg4,
	reg4 => reg5,
	class0 => class1,
	class1 => class2, 
	class2 => class3,
	class3 => class4,
	class4 => class5,
	valid_out => valid2(1)
	
);

inst_datapath2_2: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(1),
	A => out_data(63 downto 32),
	class => class,
	reg0 => reg6, 
	reg1 => reg7,
	reg2 => reg8, 
	reg3 => reg9,
	reg4 => reg10,
	class0 => class6,
	class1 => class7, 
	class2 => class8,
	class3 => class9,
	class4 => class10,
	valid_out => valid2(2)
);
valid_data2(1) <= valid2(1) and valid2(2);
inst_datapath2_3: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(2),
	A => out_data(95 downto 64),
	class => class,
	reg0 => reg11, 
	reg1 => reg12,
	reg2 => reg13, 
	reg3 => reg14,
	reg4 => reg15,
	class0 => class11,
	class1 => class12, 
	class2 => class13,
	class3 => class14,
	class4 => class15,
	valid_out => valid2(3)
	
);

inst_datapath2_4: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(3),
	A => out_data(127 downto 96),
	class => class,
	reg0 => reg16, 
	reg1 => reg17,
	reg2 => reg18, 
	reg3 => reg19,
	reg4 => reg20,
	class0 => class16,
	class1 => class17, 
	class2 => class18,
	class3 => class19,
	class4 => class20,
	valid_out => valid2(4)
);

valid_data2(2) <= valid2(3) and valid2(4);
inst_datapath2_5: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(4),
	A => out_data(159 downto 128),
	class => class,
	reg0 => reg21, 
	reg1 => reg22,
	reg2 => reg23, 
	reg3 => reg24,
	reg4 => reg25,
	class0 => class21,
	class1 => class22, 
	class2 => class23,
	class3 => class24,
	class4 => class25,
	valid_out => valid2(5)
);

inst_datapath2_6: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(5),
	A => out_data(191 downto 160),
	class => class,
	reg0 => reg26, 
	reg1 => reg27,
	reg2 => reg28, 
	reg3 => reg29,
	reg4 => reg30,
	class0 => class26,
	class1 => class27, 
	class2 => class28,
	class3 => class29,
	class4 => class30,
	valid_out => valid2(6)
);
valid_data2(3) <= valid2(5) and valid2(6);

inst_datapath2_7: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(6),
	A => out_data(223 downto 192),
	class => class,
	reg0 => reg31, 
	reg1 => reg32,
	reg2 => reg33, 
	reg3 => reg34,
	reg4 => reg35,
	class0 => class31,
	class1 => class32, 
	class2 => class33,
	class3 => class34,
	class4 => class35,
	valid_out => valid2(7)
);

inst_datapath2_8: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(7),
	A => out_data(255 downto 224),
	class => class,
	reg0 => reg36, 
	reg1 => reg37,
	reg2 => reg38, 
	reg3 => reg39,
	reg4 => reg40,
	class0 => class36,
	class1 => class37, 
	class2 => class38,
	class3 => class39,
	class4 => class40,
	valid_out => valid2(8)
);

valid_data2(4) <= valid2(7) and valid2(8);
inst_datapath2_9: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(8),
	A => out_data(287 downto 256),
	class => class,
	reg0 => reg41, 
	reg1 => reg42,
	reg2 => reg43, 
	reg3 => reg44,
	reg4 => reg45,
	class0 => class41,
	class1 => class42, 
	class2 => class43,
	class3 => class44,
	class4 => class45,
	valid_out => valid2(9)
);

inst_datapath2_10: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(9),
	A => out_data(319 downto 288),
	class => class,
	reg0 => reg46, 
	reg1 => reg47,
	reg2 => reg48, 
	reg3 => reg49,
	reg4 => reg50,
	class0 => class46,
	class1 => class47, 
	class2 => class48,
	class3 => class49,
	class4 => class50,
	valid_out => valid2(10)
);
valid_data2(5) <= valid2(9) and valid2(10);

inst_datapath2_11: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(10),
	A => out_data(351 downto 320),
	class => class,
	reg0 => reg51, 
	reg1 => reg52,
	reg2 => reg53, 
	reg3 => reg54,
	reg4 => reg55,
	class0 => class51,
	class1 => class52, 
	class2 => class53,
	class3 => class54,
	class4 => class55,
	valid_out => valid2(11)
);

inst_datapath2_12: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(11),
	A => out_data(383 downto 352),
	class => class,
	reg0 => reg56, 
	reg1 => reg57,
	reg2 => reg58, 
	reg3 => reg59,
	reg4 => reg60,
	class0 => class56,
	class1 => class57, 
	class2 => class58,
	class3 => class59,
	class4 => class60,
	valid_out => valid2(12)
);
valid_data2(6) <= valid2(11) and valid2(12);
inst_datapath2_13: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(12),
	A => out_data(415 downto 384),
	class => class,
	reg0 => reg61, 
	reg1 => reg62,
	reg2 => reg63, 
	reg3 => reg64,
	reg4 => reg65,
	class0 => class61,
	class1 => class62, 
	class2 => class63,
	class3 => class64,
	class4 => class65,
	valid_out => valid2(13)
);

inst_datapath2_14: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(13),
	A => out_data(447 downto 416),
	class => class,
	reg0 => reg66, 
	reg1 => reg67,
	reg2 => reg68, 
	reg3 => reg69,
	reg4 => reg70,
	class0 => class66,
	class1 => class67, 
	class2 => class68,
	class3 => class69,
	class4 => class70,
	valid_out => valid2(14)
);

valid_data2(7) <= valid2(13) and valid2(14);
inst_datapath2_15: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(14),
	A => out_data(479 downto 448),
	class => class,
	reg0 => reg71, 
	reg1 => reg72,
	reg2 => reg73, 
	reg3 => reg74,
	reg4 => reg75,
	class0 => class71,
	class1 => class72, 
	class2 => class73,
	class3 => class74,
	class4 => class75,
	valid_out => valid2(15)
);

inst_datapath2_16: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(15),
	A => out_data(511 downto 480),
	class => class,
	reg0 => reg76, 
	reg1 => reg77,
	reg2 => reg78, 
	reg3 => reg79,
	reg4 => reg80,
	class0 => class76,
	class1 => class77, 
	class2 => class78,
	class3 => class79,
	class4 => class80,
	valid_out => valid2(16)
);
valid_data2(8) <= valid2(15) and valid2(16);
inst_datapath2_17: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(16),
	A => out_data(543 downto 512),
	class => class,
	reg0 => reg81, 
	reg1 => reg82,
	reg2 => reg83, 
	reg3 => reg84,
	reg4 => reg85,
	class0 => class81,
	class1 => class82, 
	class2 => class83,
	class3 => class84,
	class4 => class85,
	valid_out => valid_data2(9)
);

inst_datapath2_18: datapath2 port map(
	clk => clk,
	rst => rst,
	load => load,
	valid => valid(17),
	A => out_data(575 downto 544),
	class => class,
	reg0 => reg86, 
	reg1 => reg87,
	reg2 => reg88, 
	reg3 => reg89,
	reg4 => reg90,
	class0 => class86,
	class1 => class87, 
	class2 => class88,
	class3 => class89,
	class4 => class90,
	valid_out => valid_data2(10)
);

inst_compare1: compare port map(
clk => clk,
rst => rst,
valid_in => valid_data2(1),
reg1 => reg1,
reg2 => reg2, 
reg3 => reg3,
reg4 => reg4,
reg5 => reg5, 
reg6 => reg6,
reg7 => reg7,
reg8 => reg8,
reg9 => reg9,
reg10 => reg10,
class1 => class1,
class2 => class2,
class3 => class3,
class4 => class4,
class5 => class5, 
class6 => class6,
class7 => class7,
class8 => class8,
class9 => class9,
class10 => class10,
regout1 => regout1,
regout2 => regout2,
regout3 => regout3,
regout4 => regout4,
regout5 => regout5,
classout1 => classout1,
classout2 => classout2,
classout3 => classout3,
classout4 => classout4,
classout5 => classout5,
valid_out => valid_out(1)
);

inst_compare2: compare port map(
clk => clk,
rst => rst,
valid_in => valid_data2(2),
reg1 => reg11,
reg2 => reg12, 
reg3 => reg13,
reg4 => reg14,
reg5 => reg15, 
reg6 => reg16,
reg7 => reg17,
reg8 => reg18,
reg9 => reg19,
reg10 => reg20,
class1 => class11,
class2 => class12,
class3 => class13,
class4 => class14,
class5 => class15, 
class6 => class16,
class7 => class17,
class8 => class18,
class9 => class19,
class10 => class20,
regout1 => regout6,
regout2 => regout7,
regout3 => regout8,
regout4 => regout9,
regout5 => regout10,
classout1 => classout6,
classout2 => classout7,
classout3 => classout8,
classout4 => classout9,
classout5 => classout10,
valid_out => valid_out(2)
);

inst_compare3: compare port map(
clk => clk,
rst => rst,
valid_in => valid_data2(3),
reg1 => reg21,
reg2 => reg22, 
reg3 => reg23,
reg4 => reg24,
reg5 => reg25, 
reg6 => reg26,
reg7 => reg27,
reg8 => reg28,
reg9 => reg29,
reg10 => reg30,
class1 => class21,
class2 => class22,
class3 => class23,
class4 => class24,
class5 => class25, 
class6 => class26,
class7 => class27,
class8 => class28,
class9 => class29,
class10 => class30,
regout1 => regout11,
regout2 => regout12,
regout3 => regout13,
regout4 => regout14,
regout5 => regout15,
classout1 => classout11,
classout2 => classout12,
classout3 => classout13,
classout4 => classout14,
classout5 => classout15,
valid_out => valid_out(3)
);

inst_compare4: compare port map(
clk => clk,
rst => rst,
valid_in => valid_data2(4),
reg1 => reg31,
reg2 => reg32, 
reg3 => reg33,
reg4 => reg34,
reg5 => reg35, 
reg6 => reg36,
reg7 => reg37,
reg8 => reg38,
reg9 => reg39,
reg10 => reg40,
class1 => class31,
class2 => class32,
class3 => class33,
class4 => class34,
class5 => class35, 
class6 => class36,
class7 => class37,
class8 => class38,
class9 => class39,
class10 => class40,
regout1 => regout16,
regout2 => regout17,
regout3 => regout18,
regout4 => regout19,
regout5 => regout20,
classout1 => classout16,
classout2 => classout17,
classout3 => classout18,
classout4 => classout19,
classout5 => classout20, 
valid_out => valid_out(4)
);

inst_compare5: compare port map(
clk => clk,
rst => rst,
valid_in => valid_data2(5),
reg1 => reg41,
reg2 => reg42, 
reg3 => reg43,
reg4 => reg44,
reg5 => reg45, 
reg6 => reg46,
reg7 => reg47,
reg8 => reg48,
reg9 => reg49,
reg10 => reg50,
class1 => class41,
class2 => class42,
class3 => class43,
class4 => class44,
class5 => class45, 
class6 => class46,
class7 => class47,
class8 => class48,
class9 => class49,
class10 => class50,
regout1 => regout21,
regout2 => regout22,
regout3 => regout23,
regout4 => regout24,
regout5 => regout25,
classout1 => classout21,
classout2 => classout22,
classout3 => classout23,
classout4 => classout24,
classout5 => classout25,
valid_out => valid_out(5)
);

inst_compare6: compare port map(
clk => clk,
rst => rst,
valid_in => valid_data2(6),
reg1 => reg51,
reg2 => reg52, 
reg3 => reg53,
reg4 => reg54,
reg5 => reg55, 
reg6 => reg56,
reg7 => reg57,
reg8 => reg58,
reg9 => reg59,
reg10 => reg60,
class1 => class51,
class2 => class52,
class3 => class53,
class4 => class54,
class5 => class55, 
class6 => class56,
class7 => class57,
class8 => class58,
class9 => class59,
class10 => class60,
regout1 => regout26,
regout2 => regout27,
regout3 => regout28,
regout4 => regout29,
regout5 => regout30,
classout1 => classout26,
classout2 => classout27,
classout3 => classout28,
classout4 => classout29,
classout5 => classout30,
valid_out => valid_out(6)
);

inst_compare7: compare port map(
clk => clk,
rst => rst,
valid_in => valid_data2(7),
reg1 => reg61,
reg2 => reg62, 
reg3 => reg63,
reg4 => reg64,
reg5 => reg65, 
reg6 => reg66,
reg7 => reg67,
reg8 => reg68,
reg9 => reg69,
reg10 => reg70,
class1 => class61,
class2 => class62,
class3 => class63,
class4 => class64,
class5 => class65, 
class6 => class66,
class7 => class67,
class8 => class68,
class9 => class69,
class10 => class70,
regout1 => regout31,
regout2 => regout32,
regout3 => regout33,
regout4 => regout34,
regout5 => regout35,
classout1 => classout31,
classout2 => classout32,
classout3 => classout33,
classout4 => classout34,
classout5 => classout35, 
valid_out => valid_out(7)
);

inst_compare8: compare port map(
clk => clk,
rst => rst,
valid_in => valid_data2(8),
reg1 => reg71,
reg2 => reg72, 
reg3 => reg73,
reg4 => reg74,
reg5 => reg75, 
reg6 => reg76,
reg7 => reg77,
reg8 => reg78,
reg9 => reg79,
reg10 => reg80,
class1 => class71,
class2 => class72,
class3 => class73,
class4 => class74,
class5 => class75, 
class6 => class76,
class7 => class77,
class8 => class78,
class9 => class79,
class10 => class80,
regout1 => regout36,
regout2 => regout37,
regout3 => regout38,
regout4 => regout39,
regout5 => regout40,
classout1 => classout36,
classout2 => classout37,
classout3 => classout38,
classout4 => classout39,
classout5 => classout40,
valid_out => valid_out(8)
);

valid_in(1) <=valid_out(1) and valid_out(2);
inst_compare9: compare port map(
clk => clk,
rst => rst,
valid_in => valid_in(1),
reg1 => regout1,
reg2 => regout2, 
reg3 => regout3,
reg4 => regout4,
reg5 => regout5, 
reg6 => regout6,
reg7 => regout7,
reg8 => regout8,
reg9 => regout9,
reg10 => regout10,
class1 => classout1,
class2 => classout2,
class3 => classout3,
class4 => classout4,
class5 => classout5, 
class6 => classout6,
class7 => classout7,
class8 => classout8,
class9 => classout9,
class10 => classout10,
regout1 => regout41,
regout2 => regout42,
regout3 => regout43,
regout4 => regout44,
regout5 => regout45,
classout1 => classout41,
classout2 => classout42,
classout3 => classout43,
classout4 => classout44,
classout5 => classout45,
valid_out => valid_out(9)
);

valid_in(2)<=valid_out(3) and valid_out(4);
inst_compare10: compare port map(
clk => clk,
rst => rst,
valid_in => valid_in(2),
reg1 => regout11,
reg2 => regout12, 
reg3 => regout13,
reg4 => regout14,
reg5 => regout15, 
reg6 => regout16,
reg7 => regout17,
reg8 => regout18,
reg9 => regout19,
reg10 => regout20,
class1 => classout11,
class2 => classout12,
class3 => classout13,
class4 => classout14,
class5 => classout15, 
class6 => classout16,
class7 => classout17,
class8 => classout18,
class9 => classout19,
class10 => classout20,
regout1 => regout46,
regout2 => regout47,
regout3 => regout48,
regout4 => regout49,
regout5 => regout50,
classout1 => classout46,
classout2 => classout47,
classout3 => classout48,
classout4 => classout49,
classout5 => classout50,
valid_out => valid_out(10)
);
valid_in(3)<=valid_out(5) and valid_out(6);
inst_compare11: compare port map(
clk => clk,
rst => rst,
valid_in => valid_in(3),
reg1 => regout21,
reg2 => regout22, 
reg3 => regout23,
reg4 => regout24,
reg5 => regout25, 
reg6 => regout26,
reg7 => regout27,
reg8 => regout28,
reg9 => regout29,
reg10 => regout30,
class1 => classout21,
class2 => classout22,
class3 => classout23,
class4 => classout24,
class5 => classout25, 
class6 => classout26,
class7 => classout27,
class8 => classout28,
class9 => classout29,
class10 => classout30,
regout1 => regout51,
regout2 => regout52,
regout3 => regout53,
regout4 => regout54,
regout5 => regout55,
classout1 => classout51,
classout2 => classout52,
classout3 => classout53,
classout4 => classout54,
classout5 => classout55,
valid_out => valid_out(11)
);
valid_in(4)<=valid_out(7) and valid_out(8);

inst_compare12: compare port map(
clk => clk,
rst => rst,
valid_in => valid_in(4),
reg1 => regout31,
reg2 => regout32, 
reg3 => regout33,
reg4 => regout34,
reg5 => regout35, 
reg6 => regout36,
reg7 => regout37,
reg8 => regout38,
reg9 => regout39,
reg10 => regout40,
class1 => classout31,
class2 => classout32,
class3 => classout33,
class4 => classout34,
class5 => classout35, 
class6 => classout36,
class7 => classout37,
class8 => classout38,
class9 => classout39,
class10 => classout40,
regout1 => regout56,
regout2 => regout57,
regout3 => regout58,
regout4 => regout59,
regout5 => regout60,
classout1 => classout56,
classout2 => classout57,
classout3 => classout58,
classout4 => classout59,
classout5 => classout60,
valid_out => valid_out(12)
);
valid_in(5)<=valid_out(9) and valid_out(10);
inst_compare13: compare port map(
clk => clk,
rst => rst,
valid_in=> valid_in(5),
reg1 => regout41,
reg2 => regout42, 
reg3 => regout43,
reg4 => regout44,
reg5 => regout45, 
reg6 => regout46,
reg7 => regout47,
reg8 => regout48,
reg9 => regout49,
reg10 => regout50,
class1 => classout41,
class2 => classout42,
class3 => classout43,
class4 => classout44,
class5 => classout45, 
class6 => classout46,
class7 => classout47,
class8 => classout48,
class9 => classout49,
class10 => classout50,
regout1 => regout61,
regout2 => regout62,
regout3 => regout63,
regout4 => regout64,
regout5 => regout65,
classout1 => classout61,
classout2 => classout62,
classout3 => classout63,
classout4 => classout64,
classout5 => classout65,
valid_out => valid_out(13)
);
valid_in(6)<=valid_out(11) and valid_out(12);
inst_compare14: compare port map(
clk => clk,
rst => rst,
valid_in=> valid_in(6),
reg1 => regout51,
reg2 => regout52, 
reg3 => regout53,
reg4 => regout54,
reg5 => regout55, 
reg6 => regout56,
reg7 => regout57,
reg8 => regout58,
reg9 => regout59,
reg10 => regout60,
class1 => classout51,
class2 => classout52,
class3 => classout53,
class4 => classout54,
class5 => classout55, 
class6 => classout56,
class7 => classout57,
class8 => classout58,
class9 => classout59,
class10 => classout60,
regout1 => regout66,
regout2 => regout67,
regout3 => regout68,
regout4 => regout69,
regout5 => regout70,
classout1 => classout66,
classout2 => classout67,
classout3 => classout68,
classout4 => classout69,
classout5 => classout70,
valid_out => valid_out(14)
);
valid_in(7)<=valid_out(13) and valid_out(14);
inst_compare15: compare port map(
clk => clk,
rst => rst,
valid_in => valid_in(7),
reg1 => regout61,
reg2 => regout62, 
reg3 => regout63,
reg4 => regout64,
reg5 => regout65, 
reg6 => regout66,
reg7 => regout67,
reg8 => regout68,
reg9 => regout69,
reg10 => regout70,
class1 => classout61,
class2 => classout62,
class3 => classout63,
class4 => classout64,
class5 => classout65, 
class6 => classout66,
class7 => classout67,
class8 => classout68,
class9 => classout69,
class10 => classout70,
regout1 => regout71,
regout2 => regout72,
regout3 => regout73,
regout4 => regout74,
regout5 => regout75,
classout1 => classout71,
classout2 => classout72,
classout3 => classout73,
classout4 => classout74,
classout5 => classout75,
valid_out => valid_out(15)
);
valid_in(8) <= valid_out(15) and valid_data2(9);
inst_compare16: compare port map(
clk => clk,
rst => rst,
valid_in => valid_in(8),
reg1 => reg81,
reg2 => reg82, 
reg3 => reg83,
reg4 => reg84,
reg5 => reg85, 
reg6 => regout71,
reg7 => regout72,
reg8 => regout73,
reg9 => regout74,
reg10 => regout75,
class1 => class81,
class2 => class82,
class3 => class83,
class4 => class84,
class5 => class85, 
class6 => classout71,
class7 => classout72,
class8 => classout73,
class9 => classout74,
class10 => classout75,
regout1 => regout76,
regout2 => regout77,
regout3 => regout78,
regout4 => regout79,
regout5 => regout80,
classout1 => classout76,
classout2 => classout77,
classout3 => classout78,
classout4 => classout79,
classout5 => classout80,
valid_out => valid_out(16)
);
valid_in(9) <= valid_out(16) and valid_data2(10);
inst_compare17: compare port map(
clk => clk,
rst => rst,
valid_in => valid_in(9),
reg1 => reg86,
reg2 => reg87, 
reg3 => reg88,
reg4 => reg89,
reg5 => reg90, 
reg6 => regout76,
reg7 => regout77,
reg8 => regout78,
reg9 => regout79,
reg10 => regout80,
class1 => class86,
class2 => class87,
class3 => class88,
class4 => class89,
class5 => class90, 
class6 => classout76,
class7 => classout77,
class8 => classout78,
class9 => classout79,
class10 => classout80,
regout1 => final0,
regout2 => final1,
regout3 => final2,
regout4 => final3,
regout5 => final4,
classout1 => finalclass0,
classout2 => finalclass1,
classout3 => finalclass2,
classout4 => finalclass3,
classout5 => finalclass4,
valid_out => valid_out(17)
);


 
 k_calc_reg4_0<="1" when finalclass4="00" else "0";
 k_calc_reg4_1<="1" when finalclass4="01" else "0";
 k_calc_reg4_2<="1" when finalclass4="10" else "0";
 
 k_calc_reg3_0<="1" when finalclass3="00" else "0";
 k_calc_reg3_1<="1" when finalclass3="01" else "0";
 k_calc_reg3_2<="1" when finalclass3="10" else "0";
 
 k_calc_reg2_0<="1" when finalclass2="00" else "0";
 k_calc_reg2_1<="1" when finalclass2="01" else "0";
 k_calc_reg2_2<="1" when finalclass2="10" else "0";
 
 k_calc_reg1_0<="1" when finalclass1="00" else "0";
 k_calc_reg1_1<="1" when finalclass1="01" else "0";
 k_calc_reg1_2<="1" when finalclass1="10" else "0";
 
 k_calc_reg0_0<="1" when finalclass0="00" else "0";
 k_calc_reg0_1<="1" when finalclass0="01" else "0";
 k_calc_reg0_2<="1" when finalclass0="10" else "0";



 
 
 process(clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 count0<=(others => '0');
 count1<=(others => '0');
 count2 <=(others => '0');
 elsif k="00" then
 count0 <=  "00" & unsigned(k_calc_reg4_0);
 count1 <=  "00" & unsigned(k_calc_reg4_1);
 count2 <=  "00" & unsigned(k_calc_reg4_2);
 elsif k="01" then
 count0<= (unsigned("00" & k_calc_reg4_0) + unsigned("00" & k_calc_reg3_0) + unsigned("00" & k_calc_reg2_0));
 count1<= (unsigned("00" & k_calc_reg4_1)+unsigned("00" & k_calc_reg3_1)+ unsigned("00" & k_calc_reg2_1));
 count2<= (unsigned("00" & k_calc_reg4_2)+unsigned("00" & k_calc_reg3_2)+ unsigned("00" & k_calc_reg2_2));
 elsif k="10" then
 count0<= (unsigned("00" & k_calc_reg4_0)+unsigned("00" & k_calc_reg3_0)+ unsigned("00" & k_calc_reg2_0)+unsigned("00" & k_calc_reg1_0)+unsigned("00" & k_calc_reg0_0));
 count1<= (unsigned("00" & k_calc_reg4_1)+unsigned("00" & k_calc_reg3_1)+ unsigned("00" & k_calc_reg2_1)+unsigned("00" & k_calc_reg1_1)+unsigned("00" & k_calc_reg0_1));
 count2<= (unsigned("00" & k_calc_reg4_2)+unsigned("00" & k_calc_reg3_2)+ unsigned("00" & k_calc_reg2_2)+unsigned("00" & k_calc_reg1_2)+unsigned("00" & k_calc_reg0_2));
 end if;
 end if;
 end process;
 
 aux0<="00" when ((count0>count1) and (count0>count2)) else "01" when ((count1>count0) and (count1>count2)) else "10" when ((count2>count0) and (count2>count1)) else "11"; 
 
 process(clk)
 begin
  if clk'event and clk='1' then
 if rst='1' then
 class_out <= "11";
 elsif load(0)='1' then 
 class_out <= aux0; 
 end if;
 prev_valid<=valid(0);
 end if;
 end process;

done<= '1' when  valid_out(17)='1' else '0';



end Behavioral;
