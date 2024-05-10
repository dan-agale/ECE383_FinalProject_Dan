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
	

	signal fsmCol_sig : std_logic_vector(5 downto 0);
    signal fsmRow_sig : std_logic_vector(4 downto 0);
    signal fsmWen_sig : std_logic;
    signal fsmData_sig: std_logic_vector(15 downto 0);
	signal exSel_sig: std_logic;

begin
    exSel_sig <= '0';
    
	datapath: graphics_datapath port map(
		clk => clk,
		reset_n => reset_n,
		tmds => tmds,
		tmdsb => tmdsb,
		fsmCol => fsmCol_sig,
        fsmRow => fsmRow_sig,
        fsmWen => fsmWen_sig,
        fsmData => fsmData_sig,
		exCol => "000000",
		exRow => "00000",
		exWen => '0',
		exSel => exSel_sig,
		exData => "0000000000000000");		
			  
	control: graphics_fsm port  map( 
		clk => clk,
		reset_n => reset_n,
		fsmCol => fsmCol_sig,
        fsmRow => fsmRow_sig,
        fsmWen => fsmWen_sig,
        fsmData => fsmData_sig);

end behavior;
