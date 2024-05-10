----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2024 09:42:20 PM
-- Design Name: 
-- Module Name: randomNum - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity randomNum is
    Port (  clk: in STD_LOGIC;
            reset_n : in STD_LOGIC;
            rand: out std_logic_vector(7 downto 0)
    );
end randomNum;

architecture Behavioral of randomNum is

    signal curNum, nextNum: std_logic_vector(7 downto 0);
    signal feedback: std_logic;
    signal count: unsigned(21 downto 0);
    
    begin
    
        
        process (clk)
        
            begin
                if (rising_edge(clk)) then
                    if reset_n = '0' then
                        curNum <= "00000001";
                    else
                        curNum <= nextNum;
                    end if;
                end if;
        end process;
        
        feedback <= curNum(4) XOR curNum(3) XOR curNum(2) XOR curNum(0);
        nextNum <= feedback & curNum(7 downto 1);
        rand <= curNum;
            
end Behavioral;