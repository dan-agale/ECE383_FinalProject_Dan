--------------------------------------------------------------------
-- Name:	Chris Coulston, modified by George York, used by Dan Agalakotuwa
-- Date:	Feb 3, 2015, used on Feb 8, 2024
-- File:	lec11.vhdl
-- HW:	Lecture 11
--	Crs:	ECE 383
--
-- Purp: The combined DP and CU for the keyboard scancode reader
--
-- Documentation:	None.
--
-- Academic Integrity Statement: I certify that, while others may have 
-- assisted me in brain storming, debugging and validating this program, 
-- the program itself is my own work. I understand that submitting code 
-- which is the work of other individuals is a violation of the honor   
-- code.  I also understand that if I knowingly give my original work to 
-- another individual is also a violation of the honor code. 
------------------------------------------------------------------------- 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ir_test is
	Port(	clk: in  STD_LOGIC;
			reset_n : in  STD_LOGIC;
			data: in std_logic;
			flag: in STD_LOGIC;
			buttonScan: out std_logic_vector(7 downto 0));
--			buttonScan: out std_logic);
end ir_test;



architecture behavior of ir_test is

component ir_fsm is
	Port(	clk: in  STD_LOGIC;
            reset : in  STD_LOGIC;
            ir_data  : in STD_LOGIC;
            flag: in std_logic;
            sw: in STD_LOGIC_VECTOR(1 downto 0);
            cw: out STD_LOGIC_VECTOR(3 downto 0)); 
end component;

component ir_dp is
	Port(	clk: in  STD_LOGIC;
            reset_n : in  STD_LOGIC;
            cw: in std_logic_vector(3 downto 0);
            sw: out std_logic_vector(1 downto 0);
            button : out std_logic_vector (31 downto 0));
end component;


	signal sw_sig: std_logic_vector(1 downto 0);
	signal cw_sig: std_logic_vector(3 downto 0);
	signal button_sig: std_logic_vector(31 downto 0);
	signal test: std_logic_vector(7 downto 0);
	
begin
    
    
    ir_fsm_inst: ir_fsm 
    Port map(    clk       => clk,
                 reset   => reset_n,
                 ir_data => data,
                 cw        => cw_sig,
                 sw        => sw_sig,
                 flag      => flag);
             
    ir_dp_inst: ir_dp
	Port map(    clk       => clk,
			     reset_n   => reset_n,
			     cw        => cw_sig,
			     sw        => sw_sig,
			     button    => button_sig);
			     
     buttonScan <= button_sig(7 downto 0);
--    test <= "01001101";
--process(button_sig)  -- Add button_sig to the sensitivity list
--    begin
--    if (button_sig = "11010100") then
--        buttonScan <= '1';
--    else 
--        buttonScan <= '0';
--    end if;
--end process;
--    buttonScan <= test;
end behavior;	