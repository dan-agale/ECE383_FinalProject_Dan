----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2024 07:39:47 PM
-- Design Name: 
-- Module Name: mouse_top_level - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mouse_top_level is
	PORT(
            clk			    :    IN			    STD_LOGIC;								--system clock input
            reset_n         :    IN             STD_LOGIC;                                --active low asynchronous reset
            ps2_clk         :    INOUT          STD_LOGIC;                                --clock signal from PS2 mouse
            ps2_data        :    INOUT          STD_LOGIC;                                --data signal from PS2 mouse
            middle          :    OUT            STD_LOGIC;    --data received from mouse
            right           :    OUT            STD_LOGIC;    --data received from mouse
            left            :    OUT            STD_LOGIC;    --data received from mouse
--            one             :    OUT            STD_LOGIC;    --data received from mouse
            mouse_data_new  :    OUT            STD_LOGIC);    
end mouse_top_level;

architecture Behavioral of mouse_top_level is

	SIGNAL mouse_data_signal   :   STD_LOGIC_VECTOR(23 DOWNTO 0);

    COMPONENT ps2_mouse IS
        GENERIC(
                clk_freq							:	INTEGER := 100_000_000;	--system clock frequency in Hz
                ps2_debounce_counter_size	:	INTEGER := 8);				--set such that 2^size/clk_freq = 5us (size = 8 for 50MHz)
        PORT(
                clk				:	IN			STD_LOGIC;								--system clock input
                reset_n			:	IN			STD_LOGIC;								--active low asynchronous reset
                ps2_clk			:	INOUT		STD_LOGIC;								--clock signal from PS2 mouse
                ps2_data		:	INOUT		STD_LOGIC;								--data signal from PS2 mouse
                mouse_data		:	OUT		    STD_LOGIC_VECTOR(23 DOWNTO 0);	--data received from mouse
                mouse_data_new	:	OUT		    STD_LOGIC);								--new data packet available flag
    END COMPONENT;

begin

    ps2_mouse_inst:  ps2_mouse
        GENERIC MAP(
            clk_freq => 100_000_000,
            ps2_debounce_counter_size => 8
        )
        PORT MAP(
        clk => clk,
        reset_n => reset_n,
        ps2_clk => ps2_clk,
        ps2_data => ps2_data,
        mouse_data => mouse_data_signal,
        mouse_data_new => mouse_data_new
        );
        
--    one <= mouse_data_signal(20);    
    middle <= mouse_data_signal(2);
    right <= mouse_data_signal(1);
    left <= mouse_data_signal(0);


end Behavioral;
