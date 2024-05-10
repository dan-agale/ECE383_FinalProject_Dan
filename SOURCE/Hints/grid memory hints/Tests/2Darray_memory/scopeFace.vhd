----------------------------------------------------------------------------------
-- Name:	George York
-- Date:	Spring 2020
-- File: scopeFace.vhd
-- HW:	Lab 1 
-- Pupr:	Scope Face component entity description for Lab 1.  This component sweeps
--			acrossthe display from left to right, and then return to the left side of 
--			the next lower row. The VGA interface determines the color of each pixel
--			on this journey with the help of the scopeFace component.
-- Doc:	Adapted from Dr Coulston's Lab exercise
-- 	


--		Total scope display is 640x480

--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity scopeFace is
    Port ( row : in  unsigned (9 downto 0);
           column : in  unsigned (9 downto 0);
           r : out  std_logic_vector(7 downto 0);
           g : out  std_logic_vector(7 downto 0);
           b : out  std_logic_vector(7 downto 0);
           ch1 : in  std_logic_vector(15 downto 0);
           ch1_enb : in  STD_LOGIC;
           ch2 : in  STD_LOGIC;
           ch2_enb : in  STD_LOGIC);
end scopeFace;

architecture Behavioral of scopeFace is
    signal graphics_on, obj1_pixel, obj2_pixel, obj3_pixel : std_logic;
    signal r_obj1, g_obj1, b_obj1, r_obj2, g_obj2, b_obj2, r_obj3, g_obj3, b_obj3 : std_logic_vector(7 downto 0);

begin


-- color map for each object
r_obj1 <= "11111111";
g_obj1 <= "11111111";
b_obj1 <= "00000000";
r_obj2 <= "11111111";
g_obj2 <= "00000000";
b_obj2 <= "11111111"; 
r_obj3 <= "00000000";
g_obj3 <= "11111111";
b_obj3 <= "11111111";
 
graphics_on <= '1' when (column < 512) and (row < 256) else '0';

r <= r_obj1 when ((graphics_on = '1') and (obj1_pixel = '1')) else
     r_obj2 when ((graphics_on = '1') and (obj2_pixel = '1')) else
     r_obj3 when ((graphics_on = '1') and (obj3_pixel = '1')) else
     "00000000";
g <= g_obj1 when ((graphics_on = '1') and (obj1_pixel = '1')) else
     g_obj2 when ((graphics_on = '1') and (obj2_pixel = '1')) else
     g_obj3 when ((graphics_on = '1') and (obj3_pixel = '1')) else
     "00000000";
b <= b_obj1 when ((graphics_on = '1') and (obj1_pixel = '1')) else
     b_obj2 when ((graphics_on = '1') and (obj2_pixel = '1')) else
     b_obj3 when ((graphics_on = '1') and (obj3_pixel = '1')) else
     "00000000";

-- draw object shapes 
-- make object1 a solid box
obj1_pixel <= '1' when (ch1(1 downto 0) = "01") else '0';

-- make object2 the boundary of the box
obj2_pixel <= '1' when (ch1(1 downto 0) = "10") and ((row(2 downto 0) = "000") or (row(2 downto 0) = "111") or (column(2 downto 0) = "000") or (column(2 downto 0) = "111")) else '0';

-- make object3 a X
obj3_pixel <= '1' when (ch1(1 downto 0) = "11")  and 
                       ((row(2 downto 0) = column(2 downto 0)) or 
                        ((row(2 downto 0) = "000") and (column(2 downto 0) = "111")) or
                        ((row(2 downto 0) = "001") and (column(2 downto 0) = "110")) or
                        ((row(2 downto 0) = "010") and (column(2 downto 0) = "101")) or
                        ((row(2 downto 0) = "011") and (column(2 downto 0) = "100")) or
                        ((row(2 downto 0) = "100") and (column(2 downto 0) = "011")) or
                        ((row(2 downto 0) = "101") and (column(2 downto 0) = "010")) or
                        ((row(2 downto 0) = "110") and (column(2 downto 0) = "001")) or
                        ((row(2 downto 0) = "111") and (column(2 downto 0) = "000")))
                         else '0';


end Behavioral;

