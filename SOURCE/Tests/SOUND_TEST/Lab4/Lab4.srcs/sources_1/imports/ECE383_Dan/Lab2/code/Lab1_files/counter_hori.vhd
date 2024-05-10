----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2024 10:53:23 PM
-- Design Name: 
-- Module Name: A mod 5 counter
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;		
use IEEE.std_logic_1164.all; 
use IEEE.NUMERIC_STD.ALL;


entity counter_hori is
	Port(	clk_count_h  : in  STD_LOGIC;
			reset_n      : in  STD_LOGIC;
--			ctrl         : in std_logic;
			roll_h         : out STD_LOGIC;
			Col          : out unsigned (9 downto 0));
end counter_hori;

architecture behavior of counter_hori is
	
--	signal 
	signal processCol    : unsigned (9 downto 0);

begin
	-----------------------------------------------------------------------------
	--		ctrl        behavior
	--		0			hold
	--		1			count up
	-----------------------------------------------------------------------------
	process(clk_count_h)
	begin
		if (rising_edge(clk_count_h)) then
			if (reset_n = '0') then                           -- reset
				processCol <= (others => '0');
				roll_h <= '0';

			elsif (processCol = 798) then   -- when Q0 is less than 4 and ctrl enabled
				processCol <= processCol + 1;                     --count up Q0 mod 4
				roll_h <= '1';
				
			elsif (processCol < 799) then   -- when Q0 is less than 4 and ctrl enabled
				processCol <= processCol + 1;                     --count up Q0 mod 4
			
			elsif (processCol = 799) then   -- when Q0 is equal to 4 and ctrl enabled
				processCol <= (others => '0');                   -- reset Q0 to 0
                roll_h <= '0';             -- set roll
                
			end if;
		end if;
	end process;
 
	-- CSA
	Col <= processCol;
	
end behavior;