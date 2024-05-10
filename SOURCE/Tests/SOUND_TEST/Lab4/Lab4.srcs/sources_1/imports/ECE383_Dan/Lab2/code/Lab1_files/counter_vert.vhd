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


entity counter_vert is
	Port(	clk_count_v      : in  STD_LOGIC;
			reset_n  : in  STD_LOGIC;
			ctrl     : in std_logic;
--			roll     : out STD_LOGIC;
			Row      : out unsigned (9 downto 0));
end counter_vert;

architecture behavior of counter_vert is
	
--	signal 
	signal processRow    : unsigned (9 downto 0);

begin
	-----------------------------------------------------------------------------
	--		ctrl        behavior
	--		0			hold
	--		1			count up
	-----------------------------------------------------------------------------
	process(clk_count_v)
	begin
		if (rising_edge(clk_count_v)) then
			if (reset_n = '0') then                           -- reset
				processRow <= (others => '0');
--				roll <= '0';
				
			elsif ((processRow < 524) and (ctrl = '1')) then   -- when Q0 is less than 4 and ctrl enabled
				processRow <= processRow + 1;                     --count up Q0 mod 4
--				roll <= '0';
				
			elsif ((processRow = 524) and (ctrl = '1')) then   -- when Q0 is equal to 4 and ctrl enabled
				processRow <= (others => '0');                   -- reset Q0 to 0
--				roll <= '1';                               -- set roll
                
			end if;
		end if;
	end process;
 
	-- CSA
	Row <= processRow;
	
end behavior;