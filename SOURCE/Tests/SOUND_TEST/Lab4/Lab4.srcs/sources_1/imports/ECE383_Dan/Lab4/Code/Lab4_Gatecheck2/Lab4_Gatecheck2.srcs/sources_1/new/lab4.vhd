----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2024 08:44:29 PM
-- Design Name: 
-- Module Name: lab4_gc_2 - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNIMACRO;
use UNIMACRO.vcomponents.all;

 entity lab4_gc_2 is
     Port ( clk : in  STD_LOGIC;
            reset_n : in  STD_LOGIC;
            ready : in STD_LOGIC;
            amplify: in signed(2 downto 0);
            amplified_interpol, amplified_uninterpol : out signed(17 downto 0));
 end lab4_gc_2;

architecture behavior of lab4_gc_2 is
    component lab4_datapath is
        port (
            clk                             : in STD_LOGIC;
            reset_n                         : in STD_LOGIC;
            cw                              : in STD_LOGIC_VECTOR(3 downto 0);
            amp                             : in signed(2 downto 0);
            amp_interpol, amp_uninterpol    : out signed(17 downto 0));
        end component;
    
    component lab4_fsm is
        Port (
            clk     : in STD_LOGIC;
            reset_n : in STD_LOGIC;
            ready   : in STD_LOGIC;
            cw      : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

	signal cw_fsm: std_logic_vector (3 downto 0);

begin

	lab4_datapath_inst: lab4_datapath port map(
		clk => clk,
		reset_n => reset_n,
        cw => cw_fsm,
		amp => amplify,
		amp_interpol => amplified_interpol,
		amp_uninterpol => amplified_uninterpol
        );
		
			  
	lab4_fsm_inst: lab4_fsm port map( 
		clk => clk,
		reset_n => reset_n,
		cw => cw_fsm,
		ready => ready);

end behavior;
