----------------------------------------------------------------------------------
-- Name:	George York
-- Date:	Spring 2020
-- File:    graphics.vhd
-- HW:	    GRAPHIC MEMORY example: 2 bits per pixel, for 640x480 display, using 40 BRAMS
-- Pupr:	need to update!!!!.  
--
-- Doc:	Adapted from Dr Coulston's Lab exercise
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library UNIMACRO;
use UNIMACRO.vcomponents.all;
library UNISIM;
use UNISIM.VComponents.all;
use work.graphicsParts.all;		


entity graphics is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
  		   tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0));
end graphics;

architecture behavior of graphics is
	
	component graphics_fsm is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           exCol: out std_logic_vector(4 downto 0);
           exRow: out std_logic_vector(3 downto 0);
           exWen : out std_logic;
           exData: out std_logic_vector(15 downto 0));
    end component;


    component graphics_datapath is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0);
           exCol : in  STD_LOGIC_VECTOR (4 downto 0);
           exRow : in  STD_LOGIC_VECTOR (3 downto 0);
           exWen : in  STD_LOGIC;
           exData : in  STD_LOGIC_VECTOR (15 downto 0));
end component;

	signal exCol_sig : std_logic_vector(4 downto 0);
    signal exRow_sig : std_logic_vector(3 downto 0);
    signal exWen_sig : std_logic;
    signal exData_sig: std_logic_vector(15 downto 0);
    
--	signal exCol1_sig : std_logic_vector(4 downto 0);
--    signal exRow1_sig : std_logic_vector(3 downto 0);
--    signal exWen1_sig : std_logic;
--    signal exData1_sig: std_logic_vector(15 downto 0);

begin
    
	datapath: graphics_datapath port map(
		clk => clk,
		reset_n => reset_n,
		tmds => tmds,
		tmdsb => tmdsb,
		exCol => exCol_sig,
		exRow => exRow_sig,
		exWen => exWen_sig,
		exData => exData_sig);		
			  
	control: graphics_fsm port  map( 
		clk => clk,
		reset_n => reset_n,
		exCol => exCol_sig,
        exRow => exRow_sig,
        exWen => exWen_sig,
        exData => exData_sig);

end behavior;
