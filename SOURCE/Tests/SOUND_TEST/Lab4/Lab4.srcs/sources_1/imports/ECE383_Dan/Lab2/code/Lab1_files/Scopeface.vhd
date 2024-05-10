--------------------------------------------------------------------------------
-- Name:	Dan Agalakotuwa
-- Date:	Jan 29, 2024
-- File:	Scopeface.vhd
-- Lab:     1
-- Crs:	    ECE 383
--
-- Purp:	Scopeface achitecture of the schematic to implement a o'scope grid
--
-- Documentation:	- C2C Flachmann pointed out that the hatches for columns
--                    start from 20 so that needs to be considered when using 
--                    mod to display the column hatches.
--                  - C2C Park helped me understand how the state machine needs
--                    to work for trigger_volt and trigger_time using a diagram
--                    and pointed me to the code provided in Lecture 9 on an
--                    example of a state machine (course website). He also helped
--                    me understand the difference between ch1 and ch1_enb.
--
-- Academic Integrity Statement: I certify that, while others may have 
-- assisted me in brain storming, debugging and validating this program, 
-- the program itself is my own work. I understand that submitting code 
-- which is the work of other individuals is a violation of the honor   
-- code.  I also understand that if I knowingly give my original work to 
-- another individual is also a violation of the honor code. 
--------------------------------------------------------------------------------

library IEEE;		
use IEEE.std_logic_1164.all; 
use IEEE.NUMERIC_STD.ALL;


entity ScopeFace is
    Port (  row          : in  unsigned(9 downto 0);
            column       : in  unsigned(9 downto 0);
			trigger_volt : in unsigned (9 downto 0);
			trigger_time : in unsigned (9 downto 0);
            r            : out  std_logic_vector(7 downto 0);
            g            : out  std_logic_vector(7 downto 0);
            b            : out  std_logic_vector(7 downto 0);
			ch1          : in std_logic;
			ch1_enb      : in std_logic;
			ch2          : in std_logic;
			ch2_enb      : in std_logic);
			
end ScopeFace;

architecture Behavioral of Scopeface is

signal gridH             : std_logic;
signal gridV             : std_logic;
signal white             : std_logic;
signal border_top        : std_logic;
signal border_bottom     : std_logic;
signal border_left       : std_logic;
signal border_right      : std_logic;
signal borders           : std_logic;

signal row_hatch         : std_logic;
signal column_hatch      : std_logic;

signal ch1_sig           : std_logic;
signal ch2_sig           : std_logic;

signal triangle_volt     : std_logic;
signal triangle_time     : std_logic;

begin

-- GRID
gridH <= '1' when (row = 20 or row = 70 or row = 120 or row = 170 or row = 220 or row = 270 or row = 320 or row = 370 or row = 420)
             else '0';
             
gridV <= '1' when (column = 20 or column = 80 or column = 140 or column = 200 or column = 260 or column = 320 or column = 380 or column = 440 or column = 500 or column = 560 or column = 620)
             else '0';
             
white <= '1' when gridH = '1' or gridV = '1'
             else '0';

-- Border for GRID
border_top      <= '1' when (row < 20)
                       else '0';
                       
border_bottom   <= '1' when (row > 420)
                       else '0';
                       
border_left     <= '1' when (column < 20)
                       else '0';
                       
border_right    <= '1' when (column > 620)
                       else '0';
                       
borders         <= '1' when (border_top = '0') and (border_bottom = '0') and (border_left = '0') and (border_right = '0')
                       else '0';

-- Hatches
row_hatch <= '1' when ((row > 19 and row < 420) and ((row -20) mod 10 = 0) and (column = 320 or column = 321 or column = 319 or column = 322 or column = 318))
                 else '0';
                 
column_hatch <= '1' when ((column > 19 and column < 620) and ((column - 20) mod 15 = 0) and (row = 220 or row = 221 or row = 222 or row = 219 or row = 218))
                    else '0';

-- Lines
ch1_sig <= '1' when (ch1 = '1' and ch1_enb = '1')
               else '0';
               
ch2_sig <= '1' when (ch2 = '1' and ch2_enb = '1')
               else '0';

-- Triangles 
triangle_volt <= '1' when ((row = trigger_volt or row = trigger_volt - 1 or row = trigger_volt - 2 or row = trigger_volt - 3 or row = trigger_volt + 1 or row = trigger_volt + 2 or row = trigger_volt + 3) and (column = 20)) or
                          ((row = trigger_volt or row = trigger_volt - 1 or row = trigger_volt - 2 or row = trigger_volt + 1 or row = trigger_volt + 2) and (column = 21)) or
                          ((row = trigger_volt or row = trigger_volt - 1 or row = trigger_volt + 1) and (column = 22)) or
                          ((row = trigger_volt) and (column = 23))
                     else '0';

triangle_time <= '1' when ((column = trigger_time or column = trigger_time - 1 or column = trigger_time - 2 or column = trigger_time - 3 or column = trigger_time + 1 or column = trigger_time + 2 or column = trigger_time + 3) and (row = 20)) or
                          ((column = trigger_time or column = trigger_time - 1 or column = trigger_time - 2 or column = trigger_time + 1 or column = trigger_time + 2) and (row = 21)) or
                          ((column = trigger_time or column = trigger_time - 1 or column = trigger_time + 1) and (row = 22)) or
                          ((column = trigger_time) and (row = 23))
                     else '0';

r <= "11111111" when (((white = '1' or ch1_sig = '1') and borders = '1') or triangle_time = '1' or row_hatch = '1' or column_hatch = '1')
                else "00000000";
                
g <= "11111111" when (((white = '1' or ch1_sig = '1' or ch2_sig = '1') and borders = '1') or triangle_volt = '1' or triangle_time = '1' or row_hatch = '1' or column_hatch = '1')
                else "00000000";
                
b <= "11111111" when ((white = '1') and borders = '1') or row_hatch = '1' or column_hatch = '1'
                else "00000000";

end Behavioral;
