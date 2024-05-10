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
            led0: out std_logic;
            led1: out std_logic;
            led2: out std_logic;
            led3: out std_logic;
            led4: out std_logic;
            led5: out std_logic;
            led6: out std_logic;
            led7: out std_logic
    );
end randomNum;

architecture Behavioral of randomNum is

    signal curNum, nextNum, rand: std_logic_vector(7 downto 0);
    signal feedback: std_logic;
    signal count: unsigned(21 downto 0);
    
    begin
    
	COUNTER: process(clk)
    begin
        if (rising_edge(clk)) then
            if (reset_n = '0') then
                count <= "0000000000000000000000";
            elsif count = "1111111111111111111111" then
                 count <= "0000000000000000000000";
             else
                count <= count+1;
            end if;
        end if;
    end process;
        
        feedback <= curNum(4) XOR curNum(3) XOR curNum(2) XOR curNum(0);
        nextNum <= feedback & curNum(7 downto 1);
        rand <= curNum;
        
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

    process (clk)
        begin
        if (rising_edge(clk)) then
            if count = "1111111111111111111111" then -- print to leds every time the count cycle 
                led0 <= rand(0);
                led1 <= rand(1);
                led2 <= rand(2);
                led3 <= rand(3);
                led4 <= rand(4);
                led5 <= rand(5);
                led6 <= rand(6);
                led7 <= rand(7);
            end if;
        end if;
    end process;
        
end Behavioral;