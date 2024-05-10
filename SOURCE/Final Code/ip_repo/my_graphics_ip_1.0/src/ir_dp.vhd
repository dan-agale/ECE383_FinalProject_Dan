--------------------------------------------------------------------
-- Name:	Dananga Agalakotuwa
-- Date:	May 2024
-- File:	ir_dp.vhd
-- HW:	    Final Project
-- Crs:     ECE 383
-- Purp:	Datapath for IR sensor. 
--
-- Academic Integrity Statement: I certify that, while others may have 
-- assisted me in brain storming, debugging and validating this program, 
-- the program itself is my own work. I understand that submitting code 
-- which is the work of other individuals is a violation of the honor   
-- code.  I also understand that if I knowingly give my original work to 
-- another individual is also a violation of the honor code. 
------------------------------------------------------------------------- 
library IEEE;		
use IEEE.std_logic_1164.all; 
use IEEE.NUMERIC_STD.ALL;
library UNIMACRO;
use UNIMACRO.vcomponents.all;

entity ir_dp is
	Port(	clk: in  STD_LOGIC;
			reset_n : in  STD_LOGIC;
			cw: in std_logic_vector(3 downto 0);
			sw: out std_logic_vector(1 downto 0);
			button : out std_logic_vector (31 downto 0));
end ir_dp;

architecture behavior of ir_dp is

	signal i_sig: integer;
	signal shiftReg: std_logic_vector (31 downto 0);
	signal comp1000, comp2000: std_logic;
		
	
begin
	
	
	-----------------------------------------------------------------------------
	--     This counter runs a timer that counts the time interval for each
	--     half-bit of the IR data
	--
	--     cw1     cw0
	--     1       1			unused
	--     1       0			hold
	--     0       1   			count up
	--     0       0			reset
	-----------------------------------------------------------------------------
	process(clk)
        begin
            if (rising_edge(clk)) then
    			if (reset_n = '0') then
    				i_sig <= 0;
                elsif (cw(1 downto 0) = "10") then
                    i_sig <= i_sig;  
                elsif (cw(1 downto 0) = "01") then
                     i_sig <= i_sig + 1;
                elsif (cw(1 downto 0) = "00") then
                     i_sig <= 0;
                end if;
    		end if;
	end process;
	

 	-----------------------------------------------------------------------------
	-- Comparators to check for time at 1000 us and 2000 us
 	-----------------------------------------------------------------------------
 	
 	comp1000 <= '1' when (i_sig > 100000) else '0';
 	comp2000 <= '1' when (i_sig > 200000) else '0';

 	-----------------------------------------------------------------------------
	-- Status words for figuring out what each timing means
 	-----------------------------------------------------------------------------
 	sw <= "11" when ((comp1000 = '1') and (comp2000 = '1')) else -- DONE state
          "01" when ((comp1000 = '1') and (comp2000 = '0')) else -- one state
          "00" when ((comp1000 = '0') and (comp2000 = '0'));     -- zero state
    
 	-----------------------------------------------------------------------------
    --      The shift register keeps only 31-bits 
    --      cw(3) - enable shift
    --      cw(2) - one or zero to write
    -----------------------------------------------------------------------------
	process(clk)
	begin
		if (rising_edge(clk)) then
			if (reset_n = '0') then
				shiftReg <= (others => '0');
			elsif (cw(3) = '1') then
				shiftReg <= shiftReg(30 downto 0) & cw(2);
			end if;
		end if;
	end process;
	
    button <= shiftReg;
	
   
end behavior;