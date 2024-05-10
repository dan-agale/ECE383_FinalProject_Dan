----------------------------------------------------------------------------------
-- Name:	Dananga Agalakotuwa
-- Date:	May 2024
-- File:    random_number_generator.vhd
-- HW:      Final Project
-- Pupr:	Datapath for grid memory with one instance of BRAM used. 
--          5 bits per grid cell, for a 20 x 15 grid of 32x32 pixels each

-- Doc:     Used the hints given to us in the ECE 383 websites
----------------------------------------------------------------------------------
 
 
 library IEEE;
 use IEEE.STD_LOGIC_1164.ALL;
 use IEEE.NUMERIC_STD.ALL;
 
 entity randomNum is
     Port (  clk: in STD_LOGIC;
             reset_n : in STD_LOGIC;
             rand: out std_logic_vector(7 downto 0)
     );
 end randomNum;
 
 architecture Behavioral of randomNum is
 
     signal curNum, nextNum: std_logic_vector(7 downto 0);
     signal feedback: std_logic;
     
     begin
     
         
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
 
         
 end Behavioral;

