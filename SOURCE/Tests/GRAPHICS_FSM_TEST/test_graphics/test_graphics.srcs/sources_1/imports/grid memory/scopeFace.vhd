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
    signal graphics_on, clubs, diamond, heart, spades, zero, one, ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, back, playerbox, dealerBox, topBorder, bottomBorder, greenBox, winBox, loseBox : std_logic;
    signal red, blank, black : std_logic_vector(7 downto 0);

begin

 
graphics_on <= '1' when (column < 640) and (row < 480) else '0';


    
    
r <= x"00" when ((graphics_on = '1') and (clubs     = '1' or
                                          spades    = '1' or
                                          ace       = '1' or
                                          zero      = '1' or
                                          one       = '1' or
                                          two       = '1' or
                                          three     = '1' or
                                          four      = '1' or
                                          five      = '1' or
                                          six       = '1' or
                                          seven     = '1' or
                                          eight     = '1' or
                                          nine      = '1' or
                                          ten       = '1' or
                                          jack      = '1' or
                                          queen     = '1' or
                                          king      = '1' or
                                          playerBox = '1' or
                                          dealerBox = '1' or
                                          topBorder = '1' or
                                          bottomBorder = '1'))
           else
x"18" when ((graphics_on = '1') and (greenBox   = '1' or winBox = '1'))
           else
x"F3" when ((graphics_on = '1') and (loseBox = '1'))
           else
x"DE" when ((graphics_on = '1') and (back     = '1'))
           else
     x"FF";

b <= x"00" when ((graphics_on = '1') and ( heart     = '1' or
                                           diamond   = '1' or
                                           clubs     = '1' or
                                           spades    = '1' or
                                           ace       = '1' or
                                           zero      = '1' or
                                           one       = '1' or
                                           two       = '1' or
                                           three     = '1' or
                                           four      = '1' or
                                           five      = '1' or
                                           six       = '1' or
                                           seven     = '1' or
                                           eight     = '1' or
                                           nine      = '1' or
                                           ten       = '1' or
                                           jack      = '1' or
                                           queen     = '1' or
                                           king      = '1' or
                                           playerBox = '1' or
                                           dealerBox = '1' or
                                           topBorder = '1' or
                                           bottomBorder = '1'))
           else
x"4F" when ((graphics_on = '1') and (greenBox   = '1' or winBox = '1'))
           else
x"0D" when ((graphics_on = '1') and (loseBox = '1'))
           else
x"49" when ((graphics_on = '1') and (back     = '1'))
                                           else
          x"FF";
    
g <= x"00" when ((graphics_on = '1') and (  heart     = '1' or
                                            diamond   = '1' or
                                            clubs     = '1' or
                                            spades    = '1' or
                                            ace       = '1' or
                                            zero      = '1' or
                                            one       = '1' or
                                            two       = '1' or
                                            three     = '1' or
                                            four      = '1' or
                                            five      = '1' or
                                            six       = '1' or
                                            seven     = '1' or
                                            eight     = '1' or
                                            nine      = '1' or
                                            ten       = '1' or
                                            jack      = '1' or
                                            queen     = '1' or
                                            king      = '1' or
                                            playerBox = '1' or
                                            dealerBox = '1' or
                                            topBorder = '1' or
                                            bottomBorder = '1'))
           else
x"80" when ((graphics_on = '1') and (greenBox   = '1' or winBox = '1'))
           else
x"1E" when ((graphics_on = '1') and (loseBox = '1'))
           else
x"37" when ((graphics_on = '1') and (back     = '1'))
                                            else
                   x"FF";

zero <= '1' when (ch1(4 downto 0) = "11100") and 
                            (
                                ((
                                    row(4 downto 0) = "00100" or
                                    row(4 downto 0) = "00101" or
                                    row(4 downto 0) = "00110" or
                                    row(4 downto 0) = "00111"
    
                                )
                                 and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
                                )
                            ) 
                            or
                            (
                                ((
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001" or
                                    row(4 downto 0) = "10010" or
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101" or
                                    row(4 downto 0) = "10110"
                                )
                                and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "10111" or
                                    row(4 downto 0) = "11000" or
                                    row(4 downto 0) = "11001" or
                                    row(4 downto 0) = "11010" or
                                    row(4 downto 0) = "11011"
                                )
                                and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001" or
                                    row(4 downto 0) = "10010" or
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101" or
                                    row(4 downto 0) = "10110"
                                )
                                and
                                (
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
    
                                ))
                            )
   
                or------START BORDER-------------------------
                            (
                            (
                            column(4 downto 0) = 0 or
                            column(4 downto 0) = 31 ---sdgfichazldvjs
                            
                            
                            )
                            and
                            ( ---sefkskv
                            row(4 downto 0) = 0 or
                            row(4 downto 0) = 1 or
                            row(4 downto 0) = 2 or
                            row(4 downto 0) = 3 or
                            row(4 downto 0) = 4 or
                            row(4 downto 0) = 5 or
                            row(4 downto 0) = 6 or
                            row(4 downto 0) = 7 or
                            row(4 downto 0) = 8 or
                            row(4 downto 0) = 9 or
                            row(4 downto 0) = 10 or
                            row(4 downto 0) = 11 or --10
                            row(4 downto 0) = 12 or
                            row(4 downto 0) = 13 or
                            row(4 downto 0) = 14 or
                            row(4 downto 0) = 15 or
                            row(4 downto 0) = 16 or
                            row(4 downto 0) = 17 or
                            row(4 downto 0) = 18 or
                            row(4 downto 0) = 19 or
                            row(4 downto 0) = 20 or
                            row(4 downto 0) = 21 or
                            row(4 downto 0) = 22 or
                            row(4 downto 0) = 23 or
                            row(4 downto 0) = 24 or
                            row(4 downto 0) = 25 or
                            row(4 downto 0) = 26 or
                            row(4 downto 0) = 27 or
                            row(4 downto 0) = 28 or
                            row(4 downto 0) = 29 or
                            row(4 downto 0) = 30 or
                            row(4 downto 0) = 31
                            
                            )
                            )
                            or
                            (
                            (
                            row(4 downto 0) = 0 or
                            row(4 downto 0) = 31 ---sdgfichazldvjs
                            
                            
                            )
                            and
                            ( ---sefkskv
                            column(4 downto 0) = 0 or
                            column(4 downto 0) = 1 or
                            column(4 downto 0) = 2 or
                            column(4 downto 0) = 3 or
                            column(4 downto 0) = 4 or
                            column(4 downto 0) = 5 or
                            column(4 downto 0) = 6 or
                            column(4 downto 0) = 7 or
                            column(4 downto 0) = 8 or
                            column(4 downto 0) = 9 or
                            column(4 downto 0) = 10 or
                            column(4 downto 0) = 11 or --10
                            column(4 downto 0) = 12 or
                            column(4 downto 0) = 13 or
                            column(4 downto 0) = 14 or
                            column(4 downto 0) = 15 or
                            column(4 downto 0) = 16 or
                            column(4 downto 0) = 17 or
                            column(4 downto 0) = 18 or
                            column(4 downto 0) = 19 or
                            column(4 downto 0) = 20 or
                            column(4 downto 0) = 21 or
                            column(4 downto 0) = 22 or
                            column(4 downto 0) = 23 or
                            column(4 downto 0) = 24 or
                            column(4 downto 0) = 25 or
                            column(4 downto 0) = 26 or
                            column(4 downto 0) = 27 or
                            column(4 downto 0) = 28 or
                            column(4 downto 0) = 29 or
                            column(4 downto 0) = 30 or
                            column(4 downto 0) = 31
                            
                            )
                            )
                            -----------END BORDER-------------------------
                            
                          
                                  
                                
                        )
                else '0';    


loseBox <= '1' when (ch1(4 downto 0) = "11011") and 
                                ((
    (
        row(4 downto 0) = 2
        

    )
     and
    (
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 28 or
        column(4 downto 0) = 29 or
        column(4 downto 0) = 30

    )
)
or
(
    (
        row(4 downto 0) = 3
        

    )
     and
    (
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 28 or
        column(4 downto 0) = 29 or
        column(4 downto 0) = 30

    )
)
or
(
    (
        row(4 downto 0) = 4
        

    )
     and
    (
        column(4 downto 0) = 21 or
        column(4 downto 0) = 22 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 28 or
        column(4 downto 0) = 29 or
        column(4 downto 0) = 30

    )
)
or
(
    (   
        column(4 downto 0) = 9 or
        column(4 downto 0) = 10 or
        column(4 downto 0) = 11 or
        column(4 downto 0) = 12 or
        column(4 downto 0) = 13 or
        column(4 downto 0) = 14 or
        column(4 downto 0) = 15 or
        
        column(4 downto 0) = 19 or
        column(4 downto 0) = 20 or
        column(4 downto 0) = 21 or
        column(4 downto 0) = 22 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 28 or
        column(4 downto 0) = 29 or
        column(4 downto 0) = 30

    )
     and
    (
        row(4 downto 0) = 5

    )
)
or
(
    (
        row(4 downto 0) = 6
        

    )
     and
    (
        column(4 downto 0) = 8 or
        column(4 downto 0) = 9 or
        
        column(4 downto 0) = 15 or
        column(4 downto 0) = 16 or
        column(4 downto 0) = 17 or
        column(4 downto 0) = 18 or
        column(4 downto 0) = 19 or
        column(4 downto 0) = 20 or
        column(4 downto 0) = 21 or
        column(4 downto 0) = 22 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 28 or
        column(4 downto 0) = 29 or
        column(4 downto 0) = 30

    )
)
or
(
    (
        row(4 downto 0) = 7
        

    )
     and
    (
    
        column(4 downto 0) = 8 or
        column(4 downto 0) = 9 or

        column(4 downto 0) = 21 or
        column(4 downto 0) = 22 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 28 or
        column(4 downto 0) = 29 or
        column(4 downto 0) = 30


    )
)
or
(
    (   
        column(4 downto 0) = 7 or
        column(4 downto 0) = 8 or
        column(4 downto 0) = 9 or
        column(4 downto 0) = 10 or
        column(4 downto 0) = 11 or
        
        column(4 downto 0) = 22 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 28 or
        column(4 downto 0) = 29 or
        column(4 downto 0) = 30
        

    )
     and
    (
        row(4 downto 0) = 8

    )
)
or
(
    (   
        column(4 downto 0) = 7 or
        
        column(4 downto 0) = 11 or --10
        column(4 downto 0) = 12 or
        column(4 downto 0) = 13 or
        column(4 downto 0) = 14 or
        
        column(4 downto 0) = 22 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 28 or
        column(4 downto 0) = 29 or
        column(4 downto 0) = 30

    )
     and
    (
        row(4 downto 0) = 9

    )
)
or
(
    (   
        column(4 downto 0) = 7 or
        column(4 downto 0) = 8 or
        
        column(4 downto 0) = 22 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 28 or
        column(4 downto 0) = 29 or
        column(4 downto 0) = 30

    )
     and
    (

        row(4 downto 0) = 10

    )
)
or
(
    (   
        column(4 downto 0) = 7 or
        column(4 downto 0) = 8 or
        column(4 downto 0) = 9 or
        column(4 downto 0) = 10 or
        column(4 downto 0) = 11 or
        
        column(4 downto 0) = 22 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 28 or
        column(4 downto 0) = 29 or
        column(4 downto 0) = 30
        

    )
     and
    (

        row(4 downto 0) = 11

    )
)
or
(
    (   
        column(4 downto 0) = 7 or
        
        column(4 downto 0) = 12 or
        column(4 downto 0) = 13 or
        
        column(4 downto 0) = 22 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 28 or
        column(4 downto 0) = 29 or
        column(4 downto 0) = 30
        

    )
     and
    (

        row(4 downto 0) = 12

    )
)
or
(
    (   

        column(4 downto 0) = 7 or
        
        column(4 downto 0) = 22 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 28 or
        column(4 downto 0) = 29 or
        column(4 downto 0) = 30

    )
     and
    (

        row(4 downto 0) = 13

    )
)

or
(
    (   
        column(4 downto 0) = 7 or
        column(4 downto 0) = 8 or
        column(4 downto 0) = 9 or
        column(4 downto 0) = 10 or
        column(4 downto 0) = 11 or

        column(4 downto 0) = 22 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 28 or
        column(4 downto 0) = 29 
    )
     and
    (

        row(4 downto 0) = 14

    )
)
or
(
    (   
        column(4 downto 0) = 7 or
        
        column(4 downto 0) = 12 or
        column(4 downto 0) = 13 or
        column(4 downto 0) = 14 or
        column(4 downto 0) = 15 or
        
        column(4 downto 0) = 21 or
        column(4 downto 0) = 22 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 28 
    )
     and
    (

        row(4 downto 0) = 15

    )
)
or
(
    (   
        column(4 downto 0) = 7 or
    
        column(4 downto 0) = 10 or
        column(4 downto 0) = 11 or

        column(4 downto 0) = 21 or
        column(4 downto 0) = 22 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 26 or
        column(4 downto 0) = 27 or
        column(4 downto 0) = 20 
    )
     and
    (

        row(4 downto 0) = 16

    )
)
or
(
    (   
        column(4 downto 0) = 7 or
        column(4 downto 0) = 8 or
        column(4 downto 0) = 9 or
        column(4 downto 0) = 10 or
        
        column(4 downto 0) = 19 or
        column(4 downto 0) = 20 or
        column(4 downto 0) = 21 or
        column(4 downto 0) = 22 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 

    )
     and
    (

        row(4 downto 0) = 17

    )
)
or
(
    (   
        column(4 downto 0) = 9 or
    
        column(4 downto 0) = 10 or
        column(4 downto 0) = 11 or
        column(4 downto 0) = 12 or
        column(4 downto 0) = 13 or
        column(4 downto 0) = 14 or
        
        column(4 downto 0) = 19 

    )
     and
    (

        row(4 downto 0) = 18

    )
)
or
 (
     (   
         column(4 downto 0) = 14 or
     
         column(4 downto 0) = 18

     )
      and
     (

         row(4 downto 0) = 19

     )
 )
or
   (
       (   
        column(4 downto 0) = 14 or
        
        column(4 downto 0) = 18

       )
        and
       (

       row(4 downto 0) = 20

       )
   )
or
       (
           (   
       column(4 downto 0) = 13 or        
       column(4 downto 0) = 14 or    
       column(4 downto 0) = 18

           )
            and
           (

       row(4 downto 0) = 21

           )
       )
or
        (
            (   
        column(4 downto 0) = 13 or    
        column(4 downto 0) = 18

            )
             and
            (

        row(4 downto 0) = 22

            )
        )
or
      (
          (   
        column(4 downto 0) = 13 or    
        column(4 downto 0) = 18

          )
           and
          (

        row(4 downto 0) = 23

          )
      )
or
       (
           (   
        column(4 downto 0) = 13 or    
        column(4 downto 0) = 18

           )
            and
           (

        row(4 downto 0) = 24

           )
       )
or
     (
         (   
        column(4 downto 0) = 13 or        
        column(4 downto 0) = 14 or    
        column(4 downto 0) = 18

         )
          and
         (

        row(4 downto 0) = 25

         )
     )
or
 (
     (   
         column(4 downto 0) = 14 or
         column(4 downto 0) = 15 or
         column(4 downto 0) = 16 or
         column(4 downto 0) = 17
     )
      and
     (

         row(4 downto 0) = 26

     )
 )
                       
    
)
else '0'; 

greenBox <= '1' when (ch1(4 downto 0) = "11010") and 
-------------------------------------START OF DEALER---------------------------------
                                (
                                
                                                          ------START BORDER-------------------------
    (
    (
    column(4 downto 0) = 0 or
    column(4 downto 0) = 1 or
    column(4 downto 0) = 2 or
    column(4 downto 0) = 3 or
    column(4 downto 0) = 4 or
    column(4 downto 0) = 5 or
    column(4 downto 0) = 6 or
    column(4 downto 0) = 7 or
    column(4 downto 0) = 8 or
    column(4 downto 0) = 9 or
    column(4 downto 0) = 10 or
    column(4 downto 0) = 11 or --10
    column(4 downto 0) = 12 or
    column(4 downto 0) = 13 or
    column(4 downto 0) = 14 or
    column(4 downto 0) = 15 or
    column(4 downto 0) = 16 or
    column(4 downto 0) = 17 or
    column(4 downto 0) = 18 or
    column(4 downto 0) = 19 or
    column(4 downto 0) = 20 or
    column(4 downto 0) = 21 or
    column(4 downto 0) = 22 or
    column(4 downto 0) = 23 or
    column(4 downto 0) = 24 or
    column(4 downto 0) = 25 or
    column(4 downto 0) = 26 or
    column(4 downto 0) = 27 or
    column(4 downto 0) = 28 or
    column(4 downto 0) = 29 or
    column(4 downto 0) = 30 or
    column(4 downto 0) = 31
    
    
    )
    and
    ( ---sefkskv
    row(4 downto 0) = 0 or
    row(4 downto 0) = 1 or
    row(4 downto 0) = 2 or
    row(4 downto 0) = 3 or
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17 or
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21 or
    row(4 downto 0) = 22 or
    row(4 downto 0) = 23 or
    row(4 downto 0) = 24 or
    row(4 downto 0) = 25 or
    row(4 downto 0) = 26 or
    row(4 downto 0) = 27 or
    row(4 downto 0) = 28 or
    row(4 downto 0) = 29 or
    row(4 downto 0) = 30 or
    row(4 downto 0) = 31
    
    )
    )
                            )
                    else '0'; 

winBox <= '1' when (ch1(4 downto 0) = "11001") and 
                                ((
                                    (
                                        row(4 downto 0) = 2
                                        
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = 10

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 3
                                        
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = 10 or
                                        column(4 downto 0) = 11 or --10
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 13 or
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 15

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 4
                                        
        
                                    )
                                     and
                                    (

                                        column(4 downto 0) = 10 or
                                        column(4 downto 0) = 11 or--tfjgfhjkvhbnjbjk
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 15 or
                                        column(4 downto 0) = 16 or
                                        column(4 downto 0) = 17 or
                                        column(4 downto 0) = 18 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 20 or
                                        column(4 downto 0) = 21 or
                                        column(4 downto 0) = 22 or -- 10
                                        column(4 downto 0) = 23 or
                                        column(4 downto 0) = 24

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 11 or
                                        column(4 downto 0) = 13 or
                                        column(4 downto 0) = 17 or
                                        column(4 downto 0) = 20 or
                                        column(4 downto 0) = 21 or
                                        column(4 downto 0) = 23
        
                                    )
                                     and
                                    (
                                        row(4 downto 0) = 5

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 6
                                        
        
                                    )
                                     and
                                    (

                                        column(4 downto 0) = 11 or --10
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 16 or
                                        column(4 downto 0) = 17 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 20 or
                                        column(4 downto 0) = 22 or -- 10
                                        column(4 downto 0) = 23

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 7
                                        
        
                                    )
                                     and
                                    (
                                    
                                        column(4 downto 0) = 11 or --10
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 17 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 21 or
                                        column(4 downto 0) = 22


                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 9 or
                                        column(4 downto 0) = 10 or
                                        column(4 downto 0) = 11 or --10
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 13 or
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 17 or
                                        
                                        column(4 downto 0) = 19 or
                                        
                                        column(4 downto 0) = 21 
                                        
        
                                    )
                                     and
                                    (
                                        row(4 downto 0) = 8

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 8 or
                                        column(4 downto 0) = 9 or
                                        column(4 downto 0) = 10 or
                                        column(4 downto 0) = 11 or --10
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 13 or
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 15 or
                                        column(4 downto 0) = 16 or
                                        column(4 downto 0) = 17 or
                                        column(4 downto 0) = 18 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 20 or
                                        column(4 downto 0) = 21
        
                                    )
                                     and
                                    (
                                        row(4 downto 0) = 9

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 7 or
                                        column(4 downto 0) = 8 or
                                        column(4 downto 0) = 21
        
                                    )
                                     and
                                    (

                                        row(4 downto 0) = 10

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 5 or
                                        column(4 downto 0) = 6 or
                                        column(4 downto 0) = 7 or
                                        
                                        column(4 downto 0) = 10 or
                                        column(4 downto 0) = 11 or --10
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 13 or
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 15 or
                                        column(4 downto 0) = 16 or
                                        column(4 downto 0) = 17 or
                                        column(4 downto 0) = 18 or
                                        column(4 downto 0) = 19 or
                                        
                                        column(4 downto 0) = 21 or
                                        column(4 downto 0) = 22 
                                        
        
                                    )
                                     and
                                    (

                                        row(4 downto 0) = 11

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 4 or
                                        column(4 downto 0) = 5 or
                                        
                                        column(4 downto 0) = 8 or
                                        column(4 downto 0) = 9 or
                                        column(4 downto 0) = 10 or
                                        column(4 downto 0) = 11 or --10
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 13 or
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 15 or
                                        column(4 downto 0) = 16 or
                                        column(4 downto 0) = 17 or
                                        column(4 downto 0) = 18 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 20 or
                                        
                                        column(4 downto 0) = 23 or
                                        column(4 downto 0) = 22 
        
                                    )
                                     and
                                    (

                                        row(4 downto 0) = 12

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 4 or
                                        column(4 downto 0) = 6 or
                                        column(4 downto 0) = 7 or
                                        
                                        column(4 downto 0) = 8 or
                                        column(4 downto 0) = 9 or
                                        column(4 downto 0) = 10 or
                                        column(4 downto 0) = 11 or --10
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 13 or
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 15 or
                                        column(4 downto 0) = 16 or
                                        column(4 downto 0) = 17 or
                                        column(4 downto 0) = 18 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 20 or
                                        column(4 downto 0) = 21 or
                                        
                                        column(4 downto 0) = 23 
        
                                    )
                                     and
                                    (

                                        row(4 downto 0) = 13

                                    )
                                )

                                or
                                (
                                    (   
                                        column(4 downto 0) = 3 or
                                        column(4 downto 0) = 4 or
                                        column(4 downto 0) = 6 or
                                        
                                        column(4 downto 0) = 7 or
                                        column(4 downto 0) = 8 or
                                        column(4 downto 0) = 13 or
                                        
                                        column(4 downto 0) = 18 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 20 or
                                        column(4 downto 0) = 21 or
                                        
                                        column(4 downto 0) = 23 or
                                        column(4 downto 0) = 24 
        
                                    )
                                     and
                                    (

                                        row(4 downto 0) = 14

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 3 or
                                        
                                        column(4 downto 0) = 6 or
                                        column(4 downto 0) = 7 or
                                        column(4 downto 0) = 8 or
                                        
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 13 or
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 15 or
                                        
                                        column(4 downto 0) = 18 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 20 or
                                        column(4 downto 0) = 21 or
                                        
                                        column(4 downto 0) = 23 or
                                        column(4 downto 0) = 24
        
                                    )
                                     and
                                    (

                                        row(4 downto 0) = 15

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 3 or
                                    
                                        column(4 downto 0) = 5 or
                                        column(4 downto 0) = 6 or
                                        column(4 downto 0) = 7 or
                                        column(4 downto 0) = 8 or
                                        
                                        column(4 downto 0) = 11 or
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 13 or
                                        
                                        column(4 downto 0) = 15 or
                                        
                                        column(4 downto 0) = 18 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 20 or
                                        column(4 downto 0) = 21 or
                                        
                                        column(4 downto 0) = 23 or
                                        column(4 downto 0) = 24 or
                                        column(4 downto 0) = 25
        
                                    )
                                     and
                                    (

                                        row(4 downto 0) = 16

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 3 or
                                    
                                        column(4 downto 0) = 5 or
                                        column(4 downto 0) = 6 or
                                        column(4 downto 0) = 7 or
                                        column(4 downto 0) = 8 or
                                        
                                        column(4 downto 0) = 11 or
                                        column(4 downto 0) = 13 or
                                        
                                        column(4 downto 0) = 18 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 20 or
                                        column(4 downto 0) = 21 or
                                        column(4 downto 0) = 22 or
                                        
                                        column(4 downto 0) = 24 or
                                        column(4 downto 0) = 25
        
                                    )
                                     and
                                    (

                                        row(4 downto 0) = 17

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 3 or
                                    
                                        column(4 downto 0) = 5 or
                                        column(4 downto 0) = 6 or
                                        column(4 downto 0) = 7 or
                                        column(4 downto 0) = 8 or
                                        
                                        column(4 downto 0) = 11 or
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 13 or
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 15 or
                                        
                                        column(4 downto 0) = 18 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 20 or
                                        column(4 downto 0) = 21 or
                                        column(4 downto 0) = 22 or
                                        
                                        column(4 downto 0) = 24 or
                                        column(4 downto 0) = 25
        
                                    )
                                     and
                                    (

                                        row(4 downto 0) = 18

                                    )
                                )
                               or
                                 (
                                     (   
                                         column(4 downto 0) = 3 or
                                     
                                         column(4 downto 0) = 5 or
                                         column(4 downto 0) = 6 or
                                         column(4 downto 0) = 7 or
                                         column(4 downto 0) = 8 or
                                         
                                         column(4 downto 0) = 13 or
                                         
                                         column(4 downto 0) = 15 or
                                         
                                         column(4 downto 0) = 18 or
                                         column(4 downto 0) = 19 or
                                         column(4 downto 0) = 20 or
                                         column(4 downto 0) = 21 or
                                         column(4 downto 0) = 22 or
                                         
                                         column(4 downto 0) = 24 or
                                         column(4 downto 0) = 25
         
                                     )
                                      and
                                     (
 
                                         row(4 downto 0) = 19
 
                                     )
                                 )
                               or
                                   (
                                       (   
                                           column(4 downto 0) = 3 or
                                       
                                           column(4 downto 0) = 5 or
                                           column(4 downto 0) = 6 or
                                           column(4 downto 0) = 7 or
                                           column(4 downto 0) = 8 or
                                           
                                           column(4 downto 0) = 11 or
                                           
                                           column(4 downto 0) = 13 or
                                           column(4 downto 0) = 14 or
                                           column(4 downto 0) = 15 or
                                           
                                           column(4 downto 0) = 18 or
                                           column(4 downto 0) = 19 or
                                           column(4 downto 0) = 20 or
                                           column(4 downto 0) = 21 or
                                           column(4 downto 0) = 22 or
                                           
                                           column(4 downto 0) = 24 or
                                           column(4 downto 0) = 25
           
                                       )
                                        and
                                       (
   
                                           row(4 downto 0) = 20
   
                                       )
                                   )
                               or
                                       (
                                           (   
                                               column(4 downto 0) = 3 or
                                               column(4 downto 0) = 4 or
                                           
                                               column(4 downto 0) = 6 or
                                               column(4 downto 0) = 7 or
                                               column(4 downto 0) = 8 or
                                               
                                               column(4 downto 0) = 11 or
                                               column(4 downto 0) = 12 or
                                               column(4 downto 0) = 13 or
                                               column(4 downto 0) = 14 or
                                               
                                               column(4 downto 0) = 18 or
                                               column(4 downto 0) = 19 or
                                               column(4 downto 0) = 20 or
                                               column(4 downto 0) = 21 or
                                               column(4 downto 0) = 22 or
                                               
                                               column(4 downto 0) = 24 or
                                               column(4 downto 0) = 25
               
                                           )
                                            and
                                           (
       
                                               row(4 downto 0) = 21
       
                                           )
                                       )
                              or
                                        (
                                            (   
                                                column(4 downto 0) = 4 or
                                            
                                                column(4 downto 0) = 7 or
                                                column(4 downto 0) = 8 or
                                                column(4 downto 0) = 9 or
                                                
                                                column(4 downto 0) = 13 or
                                                
                                                column(4 downto 0) = 18 or
                                                column(4 downto 0) = 19 or
                                                column(4 downto 0) = 20 or
                                                column(4 downto 0) = 21 or
                                                column(4 downto 0) = 22 or
                                                
                                                column(4 downto 0) = 24
                
                                            )
                                             and
                                            (
        
                                                row(4 downto 0) = 22
        
                                            )
                                        )
                             or
                                      (
                                          (   
                                              column(4 downto 0) = 4 or
                                              column(4 downto 0) = 5 or
                                          
                                              column(4 downto 0) = 7 or --seifhzkjznvjkjkjjHEREERE
                                              column(4 downto 0) = 8 or
                                              column(4 downto 0) = 9 or
                                              column(4 downto 0) = 10 or
                                              column(4 downto 0) = 11 or --10
                                              column(4 downto 0) = 12 or
                                              column(4 downto 0) = 13 or
                                              column(4 downto 0) = 14 or
                                              column(4 downto 0) = 15 or
                                              column(4 downto 0) = 16 or
                                              column(4 downto 0) = 17 or
                                              column(4 downto 0) = 18 or
                                              column(4 downto 0) = 19 or
                                              column(4 downto 0) = 20 or
                                              column(4 downto 0) = 21 or
                                              
                                              column(4 downto 0) = 24
              
                                          )
                                           and
                                          (
      
                                              row(4 downto 0) = 23
      
                                          )
                                      )
                             or
                                       (
                                           (   
                                               column(4 downto 0) = 5 or
                                           
                                               column(4 downto 0) = 8 or
                                               column(4 downto 0) = 9 or
                                               column(4 downto 0) = 10 or
                                               column(4 downto 0) = 11 or --10
                                               column(4 downto 0) = 12 or
                                               column(4 downto 0) = 13 or
                                               column(4 downto 0) = 14 or
                                               column(4 downto 0) = 15 or
                                               column(4 downto 0) = 16 or
                                               column(4 downto 0) = 17 or
                                               column(4 downto 0) = 18 or
                                               column(4 downto 0) = 19 or
                                               column(4 downto 0) = 20 or
                                               
                                               column(4 downto 0) = 23 or
                                               column(4 downto 0) = 24
               
                                           )
                                            and
                                           (
       
                                               row(4 downto 0) = 24
       
                                           )
                                       )
                             or
                                     (
                                         (   
                                             column(4 downto 0) = 5 or
                                             column(4 downto 0) = 6 or
                                         
                                             column(4 downto 0) = 13 or
                                             column(4 downto 0) = 14 or
                                             column(4 downto 0) = 15 or
                                             column(4 downto 0) = 16 or
                                             column(4 downto 0) = 17 or
                                             column(4 downto 0) = 18 or
                                             
                                             column(4 downto 0) = 22 or
                                             column(4 downto 0) = 23
             
                                         )
                                          and
                                         (
     
                                             row(4 downto 0) = 25
     
                                         )
                                     )
                             or
                                 (
                                     (   
                                         column(4 downto 0) = 6 or
                                         column(4 downto 0) = 7 or
                                         column(4 downto 0) = 8 or
                                         column(4 downto 0) = 9 or
                                         column(4 downto 0) = 10 or
                                         
                                         column(4 downto 0) = 20 or
                                         column(4 downto 0) = 21 or
                                         column(4 downto 0) = 22
         
                                     )
                                      and
                                     (
 
                                         row(4 downto 0) = 26
 
                                     )
                                 )
                             or
                                     (
                                         (   
                                         column(4 downto 0) = 8 or
                                         column(4 downto 0) = 9 or
                                         column(4 downto 0) = 10 or
                                         column(4 downto 0) = 11 or --10
                                         column(4 downto 0) = 12 or
                                         column(4 downto 0) = 13 or
                                         column(4 downto 0) = 14 or
                                         column(4 downto 0) = 15 or
                                         column(4 downto 0) = 16 or
                                         column(4 downto 0) = 17 or
                                         column(4 downto 0) = 18 or
                                         column(4 downto 0) = 19 or
                                         column(4 downto 0) = 20 
             
                                         )
                                          and
                                         (
     
                                             row(4 downto 0) = 27     
                                         )
                                     )
                                                       
                                    
                            )
                    else '0'; 


bottomBorder <= '1' when (ch1(4 downto 0) = "11000") and 
-------------------------------------START OF DEALER---------------------------------
                                (
                                
                                                          ------START BORDER-------------------------
    (
    (
    column(4 downto 0) = 0 or
    column(4 downto 0) = 31 ---sdgfichazldvjs
    
    
    )
    and
    ( ---sefkskv
    row(4 downto 0) = 0 or
    row(4 downto 0) = 1 or
    row(4 downto 0) = 2 or
    row(4 downto 0) = 3 or
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17 or
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21 or
    row(4 downto 0) = 22 or
    row(4 downto 0) = 23 or
    row(4 downto 0) = 24 or
    row(4 downto 0) = 25 or
    row(4 downto 0) = 26 or
    row(4 downto 0) = 27 or
    row(4 downto 0) = 28 or
    row(4 downto 0) = 29 or
    row(4 downto 0) = 30 or
    row(4 downto 0) = 31
    
    )
    )
    or
    (
    (
    row(4 downto 0) = 31 ---sdgfichazldvjs
    
    
    )
    and
    ( ---sefkskv
    column(4 downto 0) = 0 or
    column(4 downto 0) = 1 or
    column(4 downto 0) = 2 or
    column(4 downto 0) = 3 or
    column(4 downto 0) = 4 or
    column(4 downto 0) = 5 or
    column(4 downto 0) = 6 or
    column(4 downto 0) = 7 or
    column(4 downto 0) = 8 or
    column(4 downto 0) = 9 or
    column(4 downto 0) = 10 or
    column(4 downto 0) = 11 or --10
    column(4 downto 0) = 12 or
    column(4 downto 0) = 13 or
    column(4 downto 0) = 14 or
    column(4 downto 0) = 15 or
    column(4 downto 0) = 16 or
    column(4 downto 0) = 17 or
    column(4 downto 0) = 18 or
    column(4 downto 0) = 19 or
    column(4 downto 0) = 20 or
    column(4 downto 0) = 21 or
    column(4 downto 0) = 22 or
    column(4 downto 0) = 23 or
    column(4 downto 0) = 24 or
    column(4 downto 0) = 25 or
    column(4 downto 0) = 26 or
    column(4 downto 0) = 27 or
    column(4 downto 0) = 28 or
    column(4 downto 0) = 29 or
    column(4 downto 0) = 30 or
    column(4 downto 0) = 31
    
    )
    )
    -----------END BORDER-------------------------
                            )
                    else '0'; 

topBorder <= '1' when (ch1(4 downto 0) = "10111") and 
-------------------------------------START OF DEALER---------------------------------
                                (
                                
                                                          ------START BORDER-------------------------
    (
    (
    column(4 downto 0) = 0 or
    column(4 downto 0) = 31 ---sdgfichazldvjs
    
    
    )
    and
    ( ---sefkskv
    row(4 downto 0) = 0 or
    row(4 downto 0) = 1 or
    row(4 downto 0) = 2 or
    row(4 downto 0) = 3 or
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17 or
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21 or
    row(4 downto 0) = 22 or
    row(4 downto 0) = 23 or
    row(4 downto 0) = 24 or
    row(4 downto 0) = 25 or
    row(4 downto 0) = 26 or
    row(4 downto 0) = 27 or
    row(4 downto 0) = 28 or
    row(4 downto 0) = 29 or
    row(4 downto 0) = 30 or
    row(4 downto 0) = 31
    
    )
    )
    or
    (
    (
    row(4 downto 0) = 0 ---sdgfichazldvjs
    
    
    )
    and
    ( ---sefkskv
    column(4 downto 0) = 0 or
    column(4 downto 0) = 1 or
    column(4 downto 0) = 2 or
    column(4 downto 0) = 3 or
    column(4 downto 0) = 4 or
    column(4 downto 0) = 5 or
    column(4 downto 0) = 6 or
    column(4 downto 0) = 7 or
    column(4 downto 0) = 8 or
    column(4 downto 0) = 9 or
    column(4 downto 0) = 10 or
    column(4 downto 0) = 11 or --10
    column(4 downto 0) = 12 or
    column(4 downto 0) = 13 or
    column(4 downto 0) = 14 or
    column(4 downto 0) = 15 or
    column(4 downto 0) = 16 or
    column(4 downto 0) = 17 or
    column(4 downto 0) = 18 or
    column(4 downto 0) = 19 or
    column(4 downto 0) = 20 or
    column(4 downto 0) = 21 or
    column(4 downto 0) = 22 or
    column(4 downto 0) = 23 or
    column(4 downto 0) = 24 or
    column(4 downto 0) = 25 or
    column(4 downto 0) = 26 or
    column(4 downto 0) = 27 or
    column(4 downto 0) = 28 or
    column(4 downto 0) = 29 or
    column(4 downto 0) = 30 or
    column(4 downto 0) = 31
    
    )
    )
    -----------END BORDER-------------------------
                            )
                    else '0'; 


playerBox <= '1' when (ch1(4 downto 0) = "10101") and 
-------------------------------------START OF DEALER---------------------------------
                                ((
                                    (
                                        row(4 downto 0) = 6
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 5 or
                                    column(4 downto 0) = 6 or
                                    column(4 downto 0) = 7 or
                                    column(4 downto 0) = 8 or
                                    
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 15 or
                                    
                                    column(4 downto 0) = 18 or
                                    column(4 downto 0) = 20 or
                                    
                                    column(4 downto 0) = 22 or
                                    column(4 downto 0) = 23 or
                                    column(4 downto 0) = 24 or
                                    
                                    column(4 downto 0) = 26 or
                                    column(4 downto 0) = 27 or
                                    column(4 downto 0) = 28
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 7
                                        
        
                                    )
                                     and
                                    (

                                    column(4 downto 0) = 5 or
                                    column(4 downto 0) = 8 or
                                    
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 14 or
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 18 or
                                    column(4 downto 0) = 20 or
                                    
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 26 or
                                    column(4 downto 0) = 28 --HERREEE

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 8
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 5 or
                                    column(4 downto 0) = 6 or
                                    column(4 downto 0) = 7 or
                                    column(4 downto 0) = 8 or
                                    
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 14 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 20 or
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 26 or
                                    column(4 downto 0) = 27 or
                                    column(4 downto 0) = 28 
                                    

                                    )
                                )
                                or
                                (
                                    (   
                                        row(4 downto 0) = 9
        
                                    )
                                     and
                                    (

                                    column(4 downto 0) = 5 or
                                    
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 14 or
                                    column(4 downto 0) = 15 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 19 or
                                    
                                    column(4 downto 0) = 22 or
                                    column(4 downto 0) = 23 or
                                    
                                    column(4 downto 0) = 26 or
                                    column(4 downto 0) = 27

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 10
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 5 or
                                    
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 14 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 19 or
                                    
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 26 or
                                    column(4 downto 0) = 28 
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 11
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 5 or
                                    
                                    column(4 downto 0) = 10 or
                                    column(4 downto 0) = 11 or --10
                                    column(4 downto 0) = 12 or
                                    
                                    column(4 downto 0) = 14 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 19 or
                                    
                                    column(4 downto 0) = 22 or
                                    column(4 downto 0) = 23 or
                                    column(4 downto 0) = 24 or
                                    
                                    column(4 downto 0) = 26 or
                                    column(4 downto 0) = 28 
                                    

                                    )
                                )
-------------------------------------END OF DEALER---------------------------------
                                
                                or------START BORDER-------------------------
                                (
                                (
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 1 or
                                column(4 downto 0) = 2 or
                                column(4 downto 0) = 3 or
                                column(4 downto 0) = 30 or                                
                                column(4 downto 0) = 31 ---sdgfichazldvjs
                                
                                
                                )
                                and
                                ( ---sefkskv
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 1 or
                                row(4 downto 0) = 2 or
                                row(4 downto 0) = 3 or
                                row(4 downto 0) = 4 or
                                row(4 downto 0) = 5 or
                                row(4 downto 0) = 6 or
                                row(4 downto 0) = 7 or
                                row(4 downto 0) = 8 or
                                row(4 downto 0) = 9 or
                                row(4 downto 0) = 10 or
                                row(4 downto 0) = 11 or --10
                                row(4 downto 0) = 12 or
                                row(4 downto 0) = 13 or
                                row(4 downto 0) = 14 or
                                row(4 downto 0) = 15 or
                                row(4 downto 0) = 16 or
                                row(4 downto 0) = 17 or
                                row(4 downto 0) = 18 or
                                row(4 downto 0) = 19 or
                                row(4 downto 0) = 20 or
                                row(4 downto 0) = 21 or
                                row(4 downto 0) = 22 or
                                row(4 downto 0) = 23 or
                                row(4 downto 0) = 24 or
                                row(4 downto 0) = 25 or
                                row(4 downto 0) = 26 or
                                row(4 downto 0) = 27 or
                                row(4 downto 0) = 28 or
                                row(4 downto 0) = 29 or
                                row(4 downto 0) = 30 or
                                row(4 downto 0) = 31
                                
                                )
                                )
                                or
                                (
                                (
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 1 or
                                row(4 downto 0) = 2 or
                                row(4 downto 0) = 3 or
                                row(4 downto 0) = 4 or
                                row(4 downto 0) = 24 or
                                row(4 downto 0) = 25 or
                                row(4 downto 0) = 26 or
                                row(4 downto 0) = 27 or
                                row(4 downto 0) = 28 or
                                row(4 downto 0) = 29 or
                                row(4 downto 0) = 30 or
                                row(4 downto 0) = 31
                                
                                
                                )
                                and
                                ( ---sefkskv
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 1 or
                                column(4 downto 0) = 2 or
                                column(4 downto 0) = 3 or
                                column(4 downto 0) = 4 or
                                column(4 downto 0) = 5 or
                                column(4 downto 0) = 6 or
                                column(4 downto 0) = 7 or
                                column(4 downto 0) = 8 or
                                column(4 downto 0) = 9 or
                                column(4 downto 0) = 10 or
                                column(4 downto 0) = 11 or --10
                                column(4 downto 0) = 12 or
                                column(4 downto 0) = 13 or
                                column(4 downto 0) = 14 or
                                column(4 downto 0) = 15 or
                                column(4 downto 0) = 16 or
                                column(4 downto 0) = 17 or
                                column(4 downto 0) = 18 or
                                column(4 downto 0) = 19 or
                                column(4 downto 0) = 20 or
                                column(4 downto 0) = 21 or
                                column(4 downto 0) = 22 or
                                column(4 downto 0) = 23 or
                                column(4 downto 0) = 24 or
                                column(4 downto 0) = 25 or
                                column(4 downto 0) = 26 or
                                column(4 downto 0) = 27 or
                                column(4 downto 0) = 28 or
                                column(4 downto 0) = 29 or
                                column(4 downto 0) = 30 or
                                column(4 downto 0) = 31
                                
                                )
                                )
                                -----------END BORDER-------------------------
                                -----------START OF SCORE-------------------------       
                                or
                                (
                                    (   
                                        row(4 downto 0) = 17
        
                                    )
                                     and
                                    (
                                    
                                    column(4 downto 0) = 8 or
                                    column(4 downto 0) = 9 or
                                    column(4 downto 0) = 10 or
                                    
                                    
                                    column(4 downto 0) = 12 or
                                    column(4 downto 0) = 13 or
                                    column(4 downto 0) = 14 or
                                    
                                    column(4 downto 0) = 16 or
                                    column(4 downto 0) = 17 or
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 20 or
                                    column(4 downto 0) = 21 or
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 24 or
                                    column(4 downto 0) = 25 or
                                    column(4 downto 0) = 26

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 18
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 8 or
                                    
                                    column(4 downto 0) = 12 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 20 or
                                    
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 24 
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 19
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 8 or
                                    column(4 downto 0) = 9 or
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 12 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 20 or
                                    column(4 downto 0) = 21 or
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 24 
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 20
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 12 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 20 or
                                    column(4 downto 0) = 21 or
                                    
                                    column(4 downto 0) = 25 or
                                    
                                    column(4 downto 0) = 24 --HEREEEEE
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 21
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 12 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 20 or
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 24 --HEREEEEE
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 22
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 8 or
                                    column(4 downto 0) = 9 or
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 12 or
                                    column(4 downto 0) = 13 or
                                    column(4 downto 0) = 14 or
                                    
                                    column(4 downto 0) = 16 or
                                    column(4 downto 0) = 17 or
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 20 or
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 24 or
                                    column(4 downto 0) = 25 or
                                    column(4 downto 0) = 26 --HEREEEEE
                                    

                                    )
                                )
                                -----------END OF SCORE-------------------------
                            )
                    else '0'; 

dealerBox <= '1' when (ch1(4 downto 0) = "10100") and 
-------------------------------------START OF DEALER---------------------------------
                                ((
                                    (
                                        row(4 downto 0) = 6
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 5 or
                                    column(4 downto 0) = 6 or
                                    column(4 downto 0) = 7 or
                                    column(4 downto 0) = 8 or
                                    
                                    column(4 downto 0) = 10 or
                                    column(4 downto 0) = 11 or --10
                                    column(4 downto 0) = 12 or
                                    
                                    column(4 downto 0) = 15 or
                                    
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 22 or
                                    column(4 downto 0) = 23 or
                                    column(4 downto 0) = 24 or
                                    
                                    column(4 downto 0) = 26 or
                                    column(4 downto 0) = 27 or
                                    column(4 downto 0) = 28
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 7
                                        
        
                                    )
                                     and
                                    (

                                    column(4 downto 0) = 6 or
                                    column(4 downto 0) = 8 or
                                    column(4 downto 0) = 10 or
                                    column(4 downto 0) = 14 or
                                    column(4 downto 0) = 16 or
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 26 or
                                    
                                    column(4 downto 0) = 28

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 8
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 6 or
                                    
                                    column(4 downto 0) = 8 or
                                    
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 14 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 26 or
                                    column(4 downto 0) = 27 or
                                    column(4 downto 0) = 28 
                                    

                                    )
                                )
                                or
                                (
                                    (   
                                        row(4 downto 0) = 9
        
                                    )
                                     and
                                    (

                                    column(4 downto 0) = 6 or
                                    
                                    column(4 downto 0) = 8 or
                                    
                                    column(4 downto 0) = 10 or
                                    column(4 downto 0) = 11 or
                                    
                                    column(4 downto 0) = 14 or
                                    column(4 downto 0) = 15 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 22 or
                                    column(4 downto 0) = 23 or
                                    
                                    column(4 downto 0) = 26 or
                                    column(4 downto 0) = 27

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 10
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 6 or
                                    
                                    column(4 downto 0) = 8 or
                                    
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 14 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 26 or
                                    column(4 downto 0) = 28 
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 11
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 5 or
                                    column(4 downto 0) = 6 or
                                    column(4 downto 0) = 7 or
                                    column(4 downto 0) = 8 or
                                    
                                    column(4 downto 0) = 10 or
                                    column(4 downto 0) = 11 or --10
                                    column(4 downto 0) = 12 or
                                    
                                    column(4 downto 0) = 14 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 18 or
                                    column(4 downto 0) = 19 or
                                    column(4 downto 0) = 20 or
                                    
                                    column(4 downto 0) = 22 or
                                    column(4 downto 0) = 23 or
                                    column(4 downto 0) = 24 or
                                    
                                    column(4 downto 0) = 26 or
                                    column(4 downto 0) = 28 
                                    

                                    )
                                )
-------------------------------------END OF DEALER---------------------------------
                                
                                or------START BORDER-------------------------
                                (
                                (
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 1 or
                                column(4 downto 0) = 2 or
                                column(4 downto 0) = 3 or
                                column(4 downto 0) = 30 or                                
                                column(4 downto 0) = 31 ---sdgfichazldvjs
                                
                                
                                )
                                and
                                ( ---sefkskv
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 1 or
                                row(4 downto 0) = 2 or
                                row(4 downto 0) = 3 or
                                row(4 downto 0) = 4 or
                                row(4 downto 0) = 5 or
                                row(4 downto 0) = 6 or
                                row(4 downto 0) = 7 or
                                row(4 downto 0) = 8 or
                                row(4 downto 0) = 9 or
                                row(4 downto 0) = 10 or
                                row(4 downto 0) = 11 or --10
                                row(4 downto 0) = 12 or
                                row(4 downto 0) = 13 or
                                row(4 downto 0) = 14 or
                                row(4 downto 0) = 15 or
                                row(4 downto 0) = 16 or
                                row(4 downto 0) = 17 or
                                row(4 downto 0) = 18 or
                                row(4 downto 0) = 19 or
                                row(4 downto 0) = 20 or
                                row(4 downto 0) = 21 or
                                row(4 downto 0) = 22 or
                                row(4 downto 0) = 23 or
                                row(4 downto 0) = 24 or
                                row(4 downto 0) = 25 or
                                row(4 downto 0) = 26 or
                                row(4 downto 0) = 27 or
                                row(4 downto 0) = 28 or
                                row(4 downto 0) = 29 or
                                row(4 downto 0) = 30 or
                                row(4 downto 0) = 31
                                
                                )
                                )
                                or
                                (
                                (
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 1 or
                                row(4 downto 0) = 2 or
                                row(4 downto 0) = 3 or
                                row(4 downto 0) = 4 or
                                row(4 downto 0) = 24 or
                                row(4 downto 0) = 25 or
                                row(4 downto 0) = 26 or
                                row(4 downto 0) = 27 or
                                row(4 downto 0) = 28 or
                                row(4 downto 0) = 29 or
                                row(4 downto 0) = 30 or
                                row(4 downto 0) = 31
                                
                                
                                )
                                and
                                ( ---sefkskv
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 1 or
                                column(4 downto 0) = 2 or
                                column(4 downto 0) = 3 or
                                column(4 downto 0) = 4 or
                                column(4 downto 0) = 5 or
                                column(4 downto 0) = 6 or
                                column(4 downto 0) = 7 or
                                column(4 downto 0) = 8 or
                                column(4 downto 0) = 9 or
                                column(4 downto 0) = 10 or
                                column(4 downto 0) = 11 or --10
                                column(4 downto 0) = 12 or
                                column(4 downto 0) = 13 or
                                column(4 downto 0) = 14 or
                                column(4 downto 0) = 15 or
                                column(4 downto 0) = 16 or
                                column(4 downto 0) = 17 or
                                column(4 downto 0) = 18 or
                                column(4 downto 0) = 19 or
                                column(4 downto 0) = 20 or
                                column(4 downto 0) = 21 or
                                column(4 downto 0) = 22 or
                                column(4 downto 0) = 23 or
                                column(4 downto 0) = 24 or
                                column(4 downto 0) = 25 or
                                column(4 downto 0) = 26 or
                                column(4 downto 0) = 27 or
                                column(4 downto 0) = 28 or
                                column(4 downto 0) = 29 or
                                column(4 downto 0) = 30 or
                                column(4 downto 0) = 31
                                
                                )
                                )
                                -----------END BORDER-------------------------
                                -----------START OF SCORE-------------------------       
                                or
                                (
                                    (   
                                        row(4 downto 0) = 17
        
                                    )
                                     and
                                    (
                                    
                                    column(4 downto 0) = 8 or
                                    column(4 downto 0) = 9 or
                                    column(4 downto 0) = 10 or
                                    
                                    
                                    column(4 downto 0) = 12 or
                                    column(4 downto 0) = 13 or
                                    column(4 downto 0) = 14 or
                                    
                                    column(4 downto 0) = 16 or
                                    column(4 downto 0) = 17 or
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 20 or
                                    column(4 downto 0) = 21 or
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 24 or
                                    column(4 downto 0) = 25 or
                                    column(4 downto 0) = 26

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 18
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 8 or
                                    
                                    column(4 downto 0) = 12 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 20 or
                                    
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 24 
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 19
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 8 or
                                    column(4 downto 0) = 9 or
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 12 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 20 or
                                    column(4 downto 0) = 21 or
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 24 
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 20
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 12 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 20 or
                                    column(4 downto 0) = 21 or
                                    
                                    column(4 downto 0) = 25 or
                                    
                                    column(4 downto 0) = 24 --HEREEEEE
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 21
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 12 or
                                    
                                    column(4 downto 0) = 16 or
                                    
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 20 or
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 24 --HEREEEEE
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 22
                                        
        
                                    )
                                     and
                                    (
                                    column(4 downto 0) = 8 or
                                    column(4 downto 0) = 9 or
                                    column(4 downto 0) = 10 or
                                    
                                    column(4 downto 0) = 12 or
                                    column(4 downto 0) = 13 or
                                    column(4 downto 0) = 14 or
                                    
                                    column(4 downto 0) = 16 or
                                    column(4 downto 0) = 17 or
                                    column(4 downto 0) = 18 or
                                    
                                    column(4 downto 0) = 20 or
                                    column(4 downto 0) = 22 or
                                    
                                    column(4 downto 0) = 24 or
                                    column(4 downto 0) = 25 or
                                    column(4 downto 0) = 26 --HEREEEEE
                                    

                                    )
                                )
                                -----------END OF SCORE-------------------------
                            )
                    else '0'; 


one <= '1' when (ch1(4 downto 0) = "10011") and 
                                ((
                                    (
                                        row(4 downto 0) = 24 or
                                        row(4 downto 0) = 25 or
                                        row(4 downto 0) = 26 or
                                        row(4 downto 0) = 27
                                        
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = 18 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 20 or
                                        column(4 downto 0) = 21

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 4 or
                                        row(4 downto 0) = 5 or
                                        row(4 downto 0) = 6 or
                                        row(4 downto 0) = 7 or
                                        row(4 downto 0) = 8 or
                                        row(4 downto 0) = 9 or
                                        row(4 downto 0) = 10 or
                                        row(4 downto 0) = 11 or --10
                                        row(4 downto 0) = 12 or
                                        row(4 downto 0) = 13 or
                                        row(4 downto 0) = 14 or
                                        row(4 downto 0) = 15 or
                                        row(4 downto 0) = 16 or
                                        row(4 downto 0) = 17 or
                                        row(4 downto 0) = 18 or
                                        row(4 downto 0) = 19 or
                                        row(4 downto 0) = 20 or
                                        row(4 downto 0) = 21 or
                                        row(4 downto 0) = 22 or -- 10
                                        row(4 downto 0) = 23 or
                                        row(4 downto 0) = 24 or
                                        row(4 downto 0) = 25 or
                                        row(4 downto 0) = 26 or
                                        row(4 downto 0) = 27
                                        
        
                                    )
                                     and
                                    (

                                        column(4 downto 0) = 15 or
                                        column(4 downto 0) = 16 or
                                        column(4 downto 0) = 17

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 5 or
                                        row(4 downto 0) = 6 or
                                        row(4 downto 0) = 7 or
                                        row(4 downto 0) = 8 or
                                        row(4 downto 0) = 9 or
                                        row(4 downto 0) = 10 or
                                        row(4 downto 0) = 11 or --10
                                        row(4 downto 0) = 12 or
                                        row(4 downto 0) = 13 or
                                        row(4 downto 0) = 14 or
                                        row(4 downto 0) = 15 or
                                        row(4 downto 0) = 16 or
                                        row(4 downto 0) = 17 or
                                        row(4 downto 0) = 18 or
                                        row(4 downto 0) = 19 or
                                        row(4 downto 0) = 20 or
                                        row(4 downto 0) = 21 or
                                        row(4 downto 0) = 22 or -- 10
                                        row(4 downto 0) = 23 or
                                        row(4 downto 0) = 24 or
                                        row(4 downto 0) = 25 or
                                        row(4 downto 0) = 26 or
                                        row(4 downto 0) = 27
                                        
        
                                    )
                                     and
                                    (

                                        column(4 downto 0) = 14

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 13
        
                                    )
                                     and
                                    (

                                        row(4 downto 0) = 6 or
                                        row(4 downto 0) = 7 or
                                        row(4 downto 0) = 8 or
                                        row(4 downto 0) = 9 or
                                        row(4 downto 0) = 10 or
                                        row(4 downto 0) = 24 or
                                        row(4 downto 0) = 25 or
                                        row(4 downto 0) = 26 or
                                        row(4 downto 0) = 27

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 7 or
                                        row(4 downto 0) = 8 or
                                        row(4 downto 0) = 9 or
                                        row(4 downto 0) = 10 or
                                        row(4 downto 0) = 24 or
                                        row(4 downto 0) = 25 or
                                        row(4 downto 0) = 26 or
                                        row(4 downto 0) = 27
                                        
        
                                    )
                                     and
                                    (

                                        column(4 downto 0) = 12

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 9 or
                                        row(4 downto 0) = 10 or
                                        row(4 downto 0) = 24 or
                                        row(4 downto 0) = 25 or
                                        row(4 downto 0) = 26 or
                                        row(4 downto 0) = 27
                                        
                                        
        
                                    )
                                     and
                                    (

                                        column(4 downto 0) = 11

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 10
        
                                    )
                                     and
                                    (
                                        row(4 downto 0) = 10 or
                                        row(4 downto 0) = 24 or
                                        row(4 downto 0) = 25 or
                                        row(4 downto 0) = 26 or
                                        row(4 downto 0) = 27

                                    )
                                )
                                
                                                           or------START BORDER-------------------------
                                (
                                (
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 31 ---sdgfichazldvjs
                                
                                
                                )
                                and
                                ( ---sefkskv
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 1 or
                                row(4 downto 0) = 2 or
                                row(4 downto 0) = 3 or
                                row(4 downto 0) = 4 or
                                row(4 downto 0) = 5 or
                                row(4 downto 0) = 6 or
                                row(4 downto 0) = 7 or
                                row(4 downto 0) = 8 or
                                row(4 downto 0) = 9 or
                                row(4 downto 0) = 10 or
                                row(4 downto 0) = 11 or --10
                                row(4 downto 0) = 12 or
                                row(4 downto 0) = 13 or
                                row(4 downto 0) = 14 or
                                row(4 downto 0) = 15 or
                                row(4 downto 0) = 16 or
                                row(4 downto 0) = 17 or
                                row(4 downto 0) = 18 or
                                row(4 downto 0) = 19 or
                                row(4 downto 0) = 20 or
                                row(4 downto 0) = 21 or
                                row(4 downto 0) = 22 or
                                row(4 downto 0) = 23 or
                                row(4 downto 0) = 24 or
                                row(4 downto 0) = 25 or
                                row(4 downto 0) = 26 or
                                row(4 downto 0) = 27 or
                                row(4 downto 0) = 28 or
                                row(4 downto 0) = 29 or
                                row(4 downto 0) = 30 or
                                row(4 downto 0) = 31
                                
                                )
                                )
                                or
                                (
                                (
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 31 ---sdgfichazldvjs
                                
                                
                                )
                                and
                                ( ---sefkskv
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 1 or
                                column(4 downto 0) = 2 or
                                column(4 downto 0) = 3 or
                                column(4 downto 0) = 4 or
                                column(4 downto 0) = 5 or
                                column(4 downto 0) = 6 or
                                column(4 downto 0) = 7 or
                                column(4 downto 0) = 8 or
                                column(4 downto 0) = 9 or
                                column(4 downto 0) = 10 or
                                column(4 downto 0) = 11 or --10
                                column(4 downto 0) = 12 or
                                column(4 downto 0) = 13 or
                                column(4 downto 0) = 14 or
                                column(4 downto 0) = 15 or
                                column(4 downto 0) = 16 or
                                column(4 downto 0) = 17 or
                                column(4 downto 0) = 18 or
                                column(4 downto 0) = 19 or
                                column(4 downto 0) = 20 or
                                column(4 downto 0) = 21 or
                                column(4 downto 0) = 22 or
                                column(4 downto 0) = 23 or
                                column(4 downto 0) = 24 or
                                column(4 downto 0) = 25 or
                                column(4 downto 0) = 26 or
                                column(4 downto 0) = 27 or
                                column(4 downto 0) = 28 or
                                column(4 downto 0) = 29 or
                                column(4 downto 0) = 30 or
                                column(4 downto 0) = 31
                                
                                )
                                )
                                -----------END BORDER-------------------------       
                                    
                            )
                    else '0'; 


back <= '1' when (ch1(4 downto 0) = "10010") and 
                                ((
                                    (
                                        row(4 downto 0) = "00000" or
                                        row(4 downto 0) = "00001"
                                        
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "00000" or
                                        column(4 downto 0) = "00001" or
                                        column(4 downto 0) = "00010" or
                                        column(4 downto 0) = "00011" or
                                        column(4 downto 0) = "00100" or
                                        column(4 downto 0) = "00101" or
                                        column(4 downto 0) = "00110" or
                                        column(4 downto 0) = "00111" or
                                        column(4 downto 0) = "01000" or
                                        column(4 downto 0) = "01001" or
                                        column(4 downto 0) = "01010" or --10
                                        column(4 downto 0) = "01011" or
                                        column(4 downto 0) = "01100" or
                                        column(4 downto 0) = "01101" or
                                        column(4 downto 0) = "01110" or
                                        column(4 downto 0) = "01111" or
                                        column(4 downto 0) = "10000" or
                                        column(4 downto 0) = "10001" or
                                        column(4 downto 0) = "10010" or
                                        column(4 downto 0) = "10011" or
                                        column(4 downto 0) = "10100" or
                                        column(4 downto 0) = "10101" or -- 10
                                        column(4 downto 0) = "10110" or
                                        column(4 downto 0) = "10111" or
                                        column(4 downto 0) = "11000" or
                                        column(4 downto 0) = "11001" or
                                        column(4 downto 0) = "11010" or
                                        column(4 downto 0) = "11011" or
                                        column(4 downto 0) = "11100" or
                                        column(4 downto 0) = "11101" or
                                        column(4 downto 0) = "11110" or
                                        column(4 downto 0) = "11111"

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 30 or
                                        row(4 downto 0) = 31
                                        
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = 0 or
                                        column(4 downto 0) = 1 or
                                        column(4 downto 0) = 2 or
                                        column(4 downto 0) = 3 or
                                        column(4 downto 0) = 4 or
                                        column(4 downto 0) = 5 or
                                        column(4 downto 0) = 6 or
                                        column(4 downto 0) = 7 or
                                        column(4 downto 0) = 8 or
                                        column(4 downto 0) = 9 or
                                        column(4 downto 0) = 10 or
                                        column(4 downto 0) = 11 or --10
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 13 or
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 15 or
                                        column(4 downto 0) = 16 or
                                        column(4 downto 0) = 17 or
                                        column(4 downto 0) = 18 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 20 or
                                        column(4 downto 0) = 21 or
                                        column(4 downto 0) = 22 or -- 10
                                        column(4 downto 0) = 23 or
                                        column(4 downto 0) = 24 or
                                        column(4 downto 0) = 25 or
                                        column(4 downto 0) = 26 or
                                        column(4 downto 0) = 27 or
                                        column(4 downto 0) = 28 or
                                        column(4 downto 0) = 29 or
                                        column(4 downto 0) = 30 or
                                        column(4 downto 0) = 31

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 2 or
                                        row(4 downto 0) = 3
                                        
        
                                    )
                                     and
                                    (

                                        column(4 downto 0) = 3 or
                                        column(4 downto 0) = 4 or
                                        
                                        column(4 downto 0) = 27 or
                                        column(4 downto 0) = 28

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 0 or
                                        column(4 downto 0) = 1 or
                                        column(4 downto 0) = 2 or
                                        column(4 downto 0) = 31 or
                                        column(4 downto 0) = 30 or
                                        column(4 downto 0) = 29
        
                                    )
                                     and
                                    (
                                        row(4 downto 0) = 0 or
                                        row(4 downto 0) = 1 or
                                        row(4 downto 0) = 2 or
                                        row(4 downto 0) = 3 or
                                        row(4 downto 0) = 4 or
                                        row(4 downto 0) = 5 or
                                        row(4 downto 0) = 6 or
                                        row(4 downto 0) = 7 or
                                        row(4 downto 0) = 8 or
                                        row(4 downto 0) = 9 or
                                        row(4 downto 0) = 10 or
                                        row(4 downto 0) = 11 or --10
                                        row(4 downto 0) = 12 or
                                        row(4 downto 0) = 13 or
                                        row(4 downto 0) = 14 or
                                        row(4 downto 0) = 15 or
                                        row(4 downto 0) = 16 or
                                        row(4 downto 0) = 17 or
                                        row(4 downto 0) = 18 or
                                        row(4 downto 0) = 19 or
                                        row(4 downto 0) = 20 or
                                        row(4 downto 0) = 21 or
                                        row(4 downto 0) = 22 or -- 10
                                        row(4 downto 0) = 23 or
                                        row(4 downto 0) = 24 or
                                        row(4 downto 0) = 25 or
                                        row(4 downto 0) = 26 or
                                        row(4 downto 0) = 27 or
                                        row(4 downto 0) = 28 or
                                        row(4 downto 0) = 29 or
                                        row(4 downto 0) = 30 or
                                        row(4 downto 0) = 31

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 28 or
                                        row(4 downto 0) = 29
                                        
        
                                    )
                                     and
                                    (

                                        column(4 downto 0) = 3 or
                                        column(4 downto 0) = 4 or
                                        
                                        column(4 downto 0) = 27 or
                                        column(4 downto 0) = 28

                                    )
                                )
                                or
                                (
                                    (
                                        row(4 downto 0) = 4 or
                                        row(4 downto 0) = 5 or
                                        row(4 downto 0) = 26 or
                                        row(4 downto 0) = 27
                                        
        
                                    )
                                     and
                                    (

                                        column(4 downto 0) = 7 or
                                        column(4 downto 0) = 8 or
                                        column(4 downto 0) = 9 or
                                        column(4 downto 0) = 10 or
                                        column(4 downto 0) = 11 or --10
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 13 or
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 15 or
                                        column(4 downto 0) = 16 or
                                        column(4 downto 0) = 17 or
                                        column(4 downto 0) = 18 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 20 or
                                        column(4 downto 0) = 21 or
                                        column(4 downto 0) = 22 or -- 10
                                        column(4 downto 0) = 23 or
                                        column(4 downto 0) = 24

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 5 or
                                        column(4 downto 0) = 6 or
                                        column(4 downto 0) = 25 or
                                        column(4 downto 0) = 26 
        
                                    )
                                     and
                                    (
                                        row(4 downto 0) = 6 or
                                        row(4 downto 0) = 7 or
                                        row(4 downto 0) = 8 or
                                        row(4 downto 0) = 9 or
                                        row(4 downto 0) = 10 or
                                        row(4 downto 0) = 11 or --10
                                        row(4 downto 0) = 12 or
                                        row(4 downto 0) = 13 or
                                        row(4 downto 0) = 14 or
                                        row(4 downto 0) = 15 or
                                        row(4 downto 0) = 16 or
                                        row(4 downto 0) = 17 or
                                        row(4 downto 0) = 18 or
                                        row(4 downto 0) = 19 or
                                        row(4 downto 0) = 20 or
                                        row(4 downto 0) = 21 or
                                        row(4 downto 0) = 22 or -- 10
                                        row(4 downto 0) = 23 or
                                        row(4 downto 0) = 24 or
                                        row(4 downto 0) = 25

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 7 or
                                        column(4 downto 0) = 8 or
                                        column(4 downto 0) = 23 or
                                        column(4 downto 0) = 24
        
                                    )
                                     and
                                    (
                                        row(4 downto 0) = 6 or
                                        row(4 downto 0) = 7 or
                                        row(4 downto 0) = 24 or
                                        row(4 downto 0) = 25

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 9 or
                                        column(4 downto 0) = 10 or
                                        column(4 downto 0) = 21 or
                                        column(4 downto 0) = 22
        
                                    )
                                     and
                                    (

                                        row(4 downto 0) = 10 or
                                        row(4 downto 0) = 11 or --10
                                        row(4 downto 0) = 12 or
                                        row(4 downto 0) = 13 or
                                        row(4 downto 0) = 14 or
                                        row(4 downto 0) = 15 or
                                        row(4 downto 0) = 16 or
                                        row(4 downto 0) = 17 or
                                        row(4 downto 0) = 18 or
                                        row(4 downto 0) = 19 or
                                        row(4 downto 0) = 20 or
                                        row(4 downto 0) = 21

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 11 or
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 19 or
                                        column(4 downto 0) = 20
        
                                    )
                                     and
                                    (

                                        row(4 downto 0) = 8 or
                                        row(4 downto 0) = 9 or
                                        row(4 downto 0) = 10 or
                                        row(4 downto 0) = 11 or --10
                                        row(4 downto 0) = 12 or
                                        row(4 downto 0) = 13 or
                                        row(4 downto 0) = 14 or

                                        row(4 downto 0) = 17 or
                                        row(4 downto 0) = 18 or
                                        row(4 downto 0) = 19 or
                                        row(4 downto 0) = 20 or
                                        row(4 downto 0) = 21 or
                                        row(4 downto 0) = 22 or -- 10
                                        row(4 downto 0) = 23

                                    )
                                )
                                or
                                (
                                    (   
                                        column(4 downto 0) = 13 or
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 17 or
                                        column(4 downto 0) = 18
        
                                    )
                                     and
                                    (

                                        row(4 downto 0) = 8 or
                                        row(4 downto 0) = 9 or
                                        row(4 downto 0) = 10 or
                                        row(4 downto 0) = 11 or --10
                                        row(4 downto 0) = 12 or

                                        row(4 downto 0) = 19 or
                                        row(4 downto 0) = 20 or
                                        row(4 downto 0) = 21 or
                                        row(4 downto 0) = 22 or -- 10
                                        row(4 downto 0) = 23

                                    )
                                )
                                
                                or
                                (
                                    (   
                                        column(4 downto 0) = 15 or
                                        column(4 downto 0) = 16
        
                                    )
                                     and
                                    (

                                        row(4 downto 0) = 8 or
                                        row(4 downto 0) = 9 or

                                        row(4 downto 0) = 15 or
                                        row(4 downto 0) = 16 or
                                        
                                        row(4 downto 0) = 22 or -- 10
                                        row(4 downto 0) = 23

                                    )
                                )
                                                       
                                    
                            )
                    else '0'; 


king <= '1' when (ch1(4 downto 0) = "10001") and 
                                (
                                    ((
                                        row(4 downto 0) = "00100" or
                                        row(4 downto 0) = "00101" or
                                        row(4 downto 0) = "00110" or
                                        row(4 downto 0) = "00111" or
                                        row(4 downto 0) = "01000" or
                                        row(4 downto 0) = "01001" or
                                        row(4 downto 0) = "01010" or
                                        row(4 downto 0) = "01011" or
                                        row(4 downto 0) = "01100" or
                                        row(4 downto 0) = "01101" or
                                        row(4 downto 0) = "01110" or
                                        row(4 downto 0) = "01111" or
                                        row(4 downto 0) = "10000" or
                                        row(4 downto 0) = "10001" or
                                        row(4 downto 0) = "10010" or
                                        row(4 downto 0) = "10011" or
                                        row(4 downto 0) = "10100" or
                                        row(4 downto 0) = "10101" or
                                        row(4 downto 0) = "10110" or
                                        row(4 downto 0) = "10111" or
                                        row(4 downto 0) = "11000" or
                                        row(4 downto 0) = "11001" or
                                        row(4 downto 0) = "11010" or
                                        row(4 downto 0) = "11011" 
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "01000" or
                                        column(4 downto 0) = "01001" or
                                        column(4 downto 0) = "01010" or
                                        column(4 downto 0) = "01011" or
                                        column(4 downto 0) = "01100"
                                    )
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "00100" or
                                        row(4 downto 0) = "00101"
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "11000"
                                    )
                                )) 
                                or
                                (
                                    ((
                                        row(4 downto 0) = "00100" or
                                        row(4 downto 0) = "00101" or
                                        row(4 downto 0) = "00110"
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "10111" 
                                    ))
                                ) 
                                or
                                (
                                    ((
                                        row(4 downto 0) = "00100" or
                                        row(4 downto 0) = "00101" or
                                        row(4 downto 0) = "00110" or
                                        row(4 downto 0) = "00111"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "10110"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "00100" or
                                        row(4 downto 0) = "00101" or
                                        row(4 downto 0) = "00110" or
                                        row(4 downto 0) = "00111" or
                                        row(4 downto 0) = "01000"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "10101"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "00100" or
                                        row(4 downto 0) = "00101" or
                                        row(4 downto 0) = "00110" or
                                        row(4 downto 0) = "00111" or
                                        row(4 downto 0) = "01000" or
                                        row(4 downto 0) = "01001"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "10100"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "00100" or
                                        row(4 downto 0) = "00101" or
                                        row(4 downto 0) = "00110" or
                                        row(4 downto 0) = "00111" or
                                        row(4 downto 0) = "01000" or
                                        row(4 downto 0) = "01001" or
                                        row(4 downto 0) = "01010" or
                                        row(4 downto 0) = "01011" or
                                        row(4 downto 0) = "01100"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "10011"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "00110" or
                                        row(4 downto 0) = "00111" or
                                        row(4 downto 0) = "01000" or
                                        row(4 downto 0) = "01001" or
                                        row(4 downto 0) = "01010" or
                                        row(4 downto 0) = "01011" or
                                        row(4 downto 0) = "01100"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "10010"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "01001" or
                                        row(4 downto 0) = "01010" or
                                        row(4 downto 0) = "01011" or
                                        row(4 downto 0) = "01100" or
                                        row(4 downto 0) = "01101" or
                                        row(4 downto 0) = "01110" or
                                        row(4 downto 0) = "01111" or
                                        row(4 downto 0) = "10000"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "10001"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "01001" or
                                        row(4 downto 0) = "01010" or
                                        row(4 downto 0) = "01011" or
                                        row(4 downto 0) = "01100" or
                                        row(4 downto 0) = "01101" or
                                        row(4 downto 0) = "01110" or
                                        row(4 downto 0) = "01111" or
                                        row(4 downto 0) = "10000" or
                                        row(4 downto 0) = "10001" or
                                        row(4 downto 0) = "10010" or
                                        row(4 downto 0) = "10011" or
                                        row(4 downto 0) = "10100" or
                                        row(4 downto 0) = "10101"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "10000"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "01101" or
                                        row(4 downto 0) = "01110" or
                                        row(4 downto 0) = "01111" or
                                        row(4 downto 0) = "10000" or
                                        row(4 downto 0) = "10001" or
                                        row(4 downto 0) = "10010" or
                                        row(4 downto 0) = "10011" or
                                        row(4 downto 0) = "10100" or
                                        row(4 downto 0) = "10101"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "01111"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "01101" or
                                        row(4 downto 0) = "01110" or
                                        row(4 downto 0) = "01111" or
                                        row(4 downto 0) = "10000" or
                                        row(4 downto 0) = "10001" or
                                        row(4 downto 0) = "10010"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "01110"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "01110" or
                                        row(4 downto 0) = "01111" or
                                        row(4 downto 0) = "10000" or
                                        row(4 downto 0) = "10001"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "01101"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "10010" or
                                        row(4 downto 0) = "10011" or
                                        row(4 downto 0) = "10100" or
                                        row(4 downto 0) = "10101" or
                                        row(4 downto 0) = "10110" or
                                        row(4 downto 0) = "10111" or
                                        row(4 downto 0) = "11000" or
                                        row(4 downto 0) = "11001"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "10001" or
                                        column(4 downto 0) = "10010"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "10100" or
                                        row(4 downto 0) = "10101" or
                                        row(4 downto 0) = "10110" or
                                        row(4 downto 0) = "10111" or
                                        row(4 downto 0) = "11000" or
                                        row(4 downto 0) = "11001" or
                                        row(4 downto 0) = "11010" or
                                        row(4 downto 0) = "11011" 
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "10011" or
                                        column(4 downto 0) = "10100" or
                                        column(4 downto 0) = "10101"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "11000" or
                                        row(4 downto 0) = "11001" or
                                        row(4 downto 0) = "11010" or
                                        row(4 downto 0) = "11011" 
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "10110" or
                                        column(4 downto 0) = "10111"
        
                                    ))
                                )
                                                             or------START BORDER-------------------------
                                (
                                (
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 31 ---sdgfichazldvjs
                                
                                
                                )
                                and
                                ( ---sefkskv
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 1 or
                                row(4 downto 0) = 2 or
                                row(4 downto 0) = 3 or
                                row(4 downto 0) = 4 or
                                row(4 downto 0) = 5 or
                                row(4 downto 0) = 6 or
                                row(4 downto 0) = 7 or
                                row(4 downto 0) = 8 or
                                row(4 downto 0) = 9 or
                                row(4 downto 0) = 10 or
                                row(4 downto 0) = 11 or --10
                                row(4 downto 0) = 12 or
                                row(4 downto 0) = 13 or
                                row(4 downto 0) = 14 or
                                row(4 downto 0) = 15 or
                                row(4 downto 0) = 16 or
                                row(4 downto 0) = 17 or
                                row(4 downto 0) = 18 or
                                row(4 downto 0) = 19 or
                                row(4 downto 0) = 20 or
                                row(4 downto 0) = 21 or
                                row(4 downto 0) = 22 or
                                row(4 downto 0) = 23 or
                                row(4 downto 0) = 24 or
                                row(4 downto 0) = 25 or
                                row(4 downto 0) = 26 or
                                row(4 downto 0) = 27 or
                                row(4 downto 0) = 28 or
                                row(4 downto 0) = 29 or
                                row(4 downto 0) = 30 or
                                row(4 downto 0) = 31
                                
                                )
                                )
                                or
                                (
                                (
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 31 ---sdgfichazldvjs
                                
                                
                                )
                                and
                                ( ---sefkskv
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 1 or
                                column(4 downto 0) = 2 or
                                column(4 downto 0) = 3 or
                                column(4 downto 0) = 4 or
                                column(4 downto 0) = 5 or
                                column(4 downto 0) = 6 or
                                column(4 downto 0) = 7 or
                                column(4 downto 0) = 8 or
                                column(4 downto 0) = 9 or
                                column(4 downto 0) = 10 or
                                column(4 downto 0) = 11 or --10
                                column(4 downto 0) = 12 or
                                column(4 downto 0) = 13 or
                                column(4 downto 0) = 14 or
                                column(4 downto 0) = 15 or
                                column(4 downto 0) = 16 or
                                column(4 downto 0) = 17 or
                                column(4 downto 0) = 18 or
                                column(4 downto 0) = 19 or
                                column(4 downto 0) = 20 or
                                column(4 downto 0) = 21 or
                                column(4 downto 0) = 22 or
                                column(4 downto 0) = 23 or
                                column(4 downto 0) = 24 or
                                column(4 downto 0) = 25 or
                                column(4 downto 0) = 26 or
                                column(4 downto 0) = 27 or
                                column(4 downto 0) = 28 or
                                column(4 downto 0) = 29 or
                                column(4 downto 0) = 30 or
                                column(4 downto 0) = 31
                                
                                )
                                )
                                -----------END BORDER-------------------------     
                                    
                            )
                    else '0'; 


queen <= '1' when (ch1(4 downto 0) = "10000") and 
                                (
                                    ((
                                        row(4 downto 0) = "00110" or
                                        row(4 downto 0) = "00111" or
                                        row(4 downto 0) = "01000" or
                                        row(4 downto 0) = "01001" or
                                        row(4 downto 0) = "01010" or
                                        row(4 downto 0) = "01011" or
                                        row(4 downto 0) = "01100" or
                                        row(4 downto 0) = "01101" or
                                        row(4 downto 0) = "01110" or
                                        row(4 downto 0) = "01111" or
                                        row(4 downto 0) = "10000" or
                                        row(4 downto 0) = "10001" or
                                        row(4 downto 0) = "10010" or
                                        row(4 downto 0) = "10011" or
                                        row(4 downto 0) = "10100" or
                                        row(4 downto 0) = "10101" or
                                        row(4 downto 0) = "10110" or
                                        row(4 downto 0) = "10111" or
                                        row(4 downto 0) = "11000" or
                                        row(4 downto 0) = "11001" 
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "01000" or
                                        column(4 downto 0) = "01001" or
                                        column(4 downto 0) = "01010" or
                                        column(4 downto 0) = "01011"
                                    )
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "00110" or
                                        row(4 downto 0) = "00111" or
                                        row(4 downto 0) = "01000" or
                                        row(4 downto 0) = "01001" or
                                        row(4 downto 0) = "01010" or
                                        row(4 downto 0) = "01011" or
                                        row(4 downto 0) = "01100" or
                                        row(4 downto 0) = "01101" or
                                        row(4 downto 0) = "01110" or
                                        row(4 downto 0) = "01111" or
                                        row(4 downto 0) = "10000" or
                                        row(4 downto 0) = "10001" or
                                        row(4 downto 0) = "10010" or
                                        row(4 downto 0) = "10011" or
                                        row(4 downto 0) = "10100" or
                                        row(4 downto 0) = "10101" or
                                        row(4 downto 0) = "10110" or
                                        row(4 downto 0) = "10111" or
                                        row(4 downto 0) = "11000" or
                                        row(4 downto 0) = "11001" or
                                        row(4 downto 0) = "11010"
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "10001" or
                                        column(4 downto 0) = "10010" or
                                        column(4 downto 0) = "10011" or
                                        column(4 downto 0) = "10100"
                                    )
                                )) 
                                or
                                (
                                    ((
                                        row(4 downto 0) = "00110" or
                                        row(4 downto 0) = "00111"
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "01100" or 
                                        column(4 downto 0) = "01101" or
                                        column(4 downto 0) = "01110" or
                                        column(4 downto 0) = "01111" or
                                        column(4 downto 0) = "10000"
                                    ))
                                ) 
                                or
                                (
                                    ((
                                        row(4 downto 0) = "00100" or
                                        row(4 downto 0) = "00101"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "01011" or
                                        column(4 downto 0) = "01100" or 
                                        column(4 downto 0) = "01101" or
                                        column(4 downto 0) = "01110" or
                                        column(4 downto 0) = "01111" or
                                        column(4 downto 0) = "10000" or
                                        column(4 downto 0) = "10001"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "00101"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "01001" or
                                        column(4 downto 0) = "01010" or
                                        column(4 downto 0) = "10010" or
                                        column(4 downto 0) = "10011"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "01000"
                                )
                                    and
                                    (
                                        column(4 downto 0) = "01100" or
                                        column(4 downto 0) = "10000" 
            
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "11010"
                                )
                                    and
                                    (
                                        column(4 downto 0) = "01001" or
                                        column(4 downto 0) = "01010" or
                                        column(4 downto 0) = "01011" or
                                        column(4 downto 0) = "01100" or 
                                        column(4 downto 0) = "01101" or
                                        column(4 downto 0) = "01110" or
                                        column(4 downto 0) = "01111" or
                                        column(4 downto 0) = "10101" or
                                        column(4 downto 0) = "10110" or
                                        column(4 downto 0) = "10111" 
            
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "11011"
                                )
                                    and
                                    (
                                        column(4 downto 0) = "01011" or
                                        column(4 downto 0) = "01100" or 
                                        column(4 downto 0) = "01101" or
                                        column(4 downto 0) = "01110" or
                                        column(4 downto 0) = "01111" or
                                        column(4 downto 0) = "10010" or
                                        column(4 downto 0) = "10011" or
                                        column(4 downto 0) = "10100" or
                                        column(4 downto 0) = "10101" or
                                        column(4 downto 0) = "10110" or
                                        column(4 downto 0) = "10111" 
            
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "10111" or
                                        row(4 downto 0) = "11000" or
                                        row(4 downto 0) = "11001"
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "01100" or 
                                        column(4 downto 0) = "01101" or
                                        column(4 downto 0) = "01110" or
                                        column(4 downto 0) = "01111" or
                                        column(4 downto 0) = "10000"
                                    ))
                                ) 
                                or
                                (
                                    ((
                                        row(4 downto 0) = "10101" or
                                        row(4 downto 0) = "10110"
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "01111" or 
                                        column(4 downto 0) = "10000"
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "10110"
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "01100"
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "10011" or
                                        row(4 downto 0) = "10100" or
                                        row(4 downto 0) = "10101"
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "01110"
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "10100"
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "01111"
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "11001"
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "10101"
                                    ))
                                )
                                                            or------START BORDER-------------------------
                                (
                                (
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 31 ---sdgfichazldvjs
                                
                                
                                )
                                and
                                ( ---sefkskv
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 1 or
                                row(4 downto 0) = 2 or
                                row(4 downto 0) = 3 or
                                row(4 downto 0) = 4 or
                                row(4 downto 0) = 5 or
                                row(4 downto 0) = 6 or
                                row(4 downto 0) = 7 or
                                row(4 downto 0) = 8 or
                                row(4 downto 0) = 9 or
                                row(4 downto 0) = 10 or
                                row(4 downto 0) = 11 or --10
                                row(4 downto 0) = 12 or
                                row(4 downto 0) = 13 or
                                row(4 downto 0) = 14 or
                                row(4 downto 0) = 15 or
                                row(4 downto 0) = 16 or
                                row(4 downto 0) = 17 or
                                row(4 downto 0) = 18 or
                                row(4 downto 0) = 19 or
                                row(4 downto 0) = 20 or
                                row(4 downto 0) = 21 or
                                row(4 downto 0) = 22 or
                                row(4 downto 0) = 23 or
                                row(4 downto 0) = 24 or
                                row(4 downto 0) = 25 or
                                row(4 downto 0) = 26 or
                                row(4 downto 0) = 27 or
                                row(4 downto 0) = 28 or
                                row(4 downto 0) = 29 or
                                row(4 downto 0) = 30 or
                                row(4 downto 0) = 31
                                
                                )
                                )
                                or
                                (
                                (
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 31 ---sdgfichazldvjs
                                
                                
                                )
                                and
                                ( ---sefkskv
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 1 or
                                column(4 downto 0) = 2 or
                                column(4 downto 0) = 3 or
                                column(4 downto 0) = 4 or
                                column(4 downto 0) = 5 or
                                column(4 downto 0) = 6 or
                                column(4 downto 0) = 7 or
                                column(4 downto 0) = 8 or
                                column(4 downto 0) = 9 or
                                column(4 downto 0) = 10 or
                                column(4 downto 0) = 11 or --10
                                column(4 downto 0) = 12 or
                                column(4 downto 0) = 13 or
                                column(4 downto 0) = 14 or
                                column(4 downto 0) = 15 or
                                column(4 downto 0) = 16 or
                                column(4 downto 0) = 17 or
                                column(4 downto 0) = 18 or
                                column(4 downto 0) = 19 or
                                column(4 downto 0) = 20 or
                                column(4 downto 0) = 21 or
                                column(4 downto 0) = 22 or
                                column(4 downto 0) = 23 or
                                column(4 downto 0) = 24 or
                                column(4 downto 0) = 25 or
                                column(4 downto 0) = 26 or
                                column(4 downto 0) = 27 or
                                column(4 downto 0) = 28 or
                                column(4 downto 0) = 29 or
                                column(4 downto 0) = 30 or
                                column(4 downto 0) = 31
                                
                                )
                                )
                                -----------END BORDER-------------------------      
                                    
                            )
                    else '0'; 


jack <= '1' when (ch1(4 downto 0) = "01111") and 
                                (
                                    ((
                                        row(4 downto 0) = "01000" or
                                        row(4 downto 0) = "01001" or
                                        row(4 downto 0) = "01010" or
                                        row(4 downto 0) = "01011" or
                                        row(4 downto 0) = "01100" or
                                        row(4 downto 0) = "01101" or
                                        row(4 downto 0) = "01110" or
                                        row(4 downto 0) = "01111" or
                                        row(4 downto 0) = "10000" or
                                        row(4 downto 0) = "10001" or
                                        row(4 downto 0) = "10010" or
                                        row(4 downto 0) = "10011" or
                                        row(4 downto 0) = "10100" or
                                        row(4 downto 0) = "10101" or
                                        row(4 downto 0) = "10110" or
                                        row(4 downto 0) = "10111" or
                                        row(4 downto 0) = "11000" or
                                        row(4 downto 0) = "11001" or
                                        row(4 downto 0) = "11010" or
                                        row(4 downto 0) = "11011"
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "10000" or
                                        column(4 downto 0) = "10001" or
                                        column(4 downto 0) = "10010" or
                                        column(4 downto 0) = "10011" or
                                        column(4 downto 0) = "10100"
                                    )
                                ) 
                                or
                                (
                                    ((
                                        row(4 downto 0) = "00100" or
                                        row(4 downto 0) = "00101" or
                                        row(4 downto 0) = "00110" or
                                        row(4 downto 0) = "00111"
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "01000" or
                                        column(4 downto 0) = "01001" or
                                        column(4 downto 0) = "01010" or
                                        column(4 downto 0) = "01011" or
                                        column(4 downto 0) = "01100" or
                                        column(4 downto 0) = "01101" or
                                        column(4 downto 0) = "01110" or
                                        column(4 downto 0) = "01111" or
                                        column(4 downto 0) = "10000" or
                                        column(4 downto 0) = "10001" or
                                        column(4 downto 0) = "10010" or
                                        column(4 downto 0) = "10011" or
                                        column(4 downto 0) = "10100" or
                                        column(4 downto 0) = "10101" or
                                        column(4 downto 0) = "10110" or
                                        column(4 downto 0) = "10111"
                                    ))
                                ) 
                                or
                                (
                                    ((
                                        row(4 downto 0) = "10111" or
                                        row(4 downto 0) = "11000" or
                                        row(4 downto 0) = "11001"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "01000" or
                                        column(4 downto 0) = "01001" or
                                        column(4 downto 0) = "01010" or
                                        column(4 downto 0) = "01011" or
                                        column(4 downto 0) = "01100" or
                                        column(4 downto 0) = "01101" or
                                        column(4 downto 0) = "01110" or
                                        column(4 downto 0) = "01111"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "10110"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "01000" or
                                        column(4 downto 0) = "01001" or
                                        column(4 downto 0) = "01010" or
                                        column(4 downto 0) = "01011" or
                                        column(4 downto 0) = "01111" 
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "11010"
                                )
                                    and
                                    (
                                        column(4 downto 0) = "01001" or
                                        column(4 downto 0) = "01010" or
                                        column(4 downto 0) = "01011" or
                                        column(4 downto 0) = "01100" or
                                        column(4 downto 0) = "01101" or
                                        column(4 downto 0) = "01110" or
                                        column(4 downto 0) = "01111"
            
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "11011"
                                )
                                    and
                                    (
                                        column(4 downto 0) = "01011" or
                                        column(4 downto 0) = "01100" or
                                        column(4 downto 0) = "01101" or
                                        column(4 downto 0) = "01110" or
                                        column(4 downto 0) = "01111"
            
                                    ))
                                )
                                                          or------START BORDER-------------------------
                                (
                                (
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 31 ---sdgfichazldvjs
                                
                                
                                )
                                and
                                ( ---sefkskv
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 1 or
                                row(4 downto 0) = 2 or
                                row(4 downto 0) = 3 or
                                row(4 downto 0) = 4 or
                                row(4 downto 0) = 5 or
                                row(4 downto 0) = 6 or
                                row(4 downto 0) = 7 or
                                row(4 downto 0) = 8 or
                                row(4 downto 0) = 9 or
                                row(4 downto 0) = 10 or
                                row(4 downto 0) = 11 or --10
                                row(4 downto 0) = 12 or
                                row(4 downto 0) = 13 or
                                row(4 downto 0) = 14 or
                                row(4 downto 0) = 15 or
                                row(4 downto 0) = 16 or
                                row(4 downto 0) = 17 or
                                row(4 downto 0) = 18 or
                                row(4 downto 0) = 19 or
                                row(4 downto 0) = 20 or
                                row(4 downto 0) = 21 or
                                row(4 downto 0) = 22 or
                                row(4 downto 0) = 23 or
                                row(4 downto 0) = 24 or
                                row(4 downto 0) = 25 or
                                row(4 downto 0) = 26 or
                                row(4 downto 0) = 27 or
                                row(4 downto 0) = 28 or
                                row(4 downto 0) = 29 or
                                row(4 downto 0) = 30 or
                                row(4 downto 0) = 31
                                
                                )
                                )
                                or
                                (
                                (
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 31 ---sdgfichazldvjs
                                
                                
                                )
                                and
                                ( ---sefkskv
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 1 or
                                column(4 downto 0) = 2 or
                                column(4 downto 0) = 3 or
                                column(4 downto 0) = 4 or
                                column(4 downto 0) = 5 or
                                column(4 downto 0) = 6 or
                                column(4 downto 0) = 7 or
                                column(4 downto 0) = 8 or
                                column(4 downto 0) = 9 or
                                column(4 downto 0) = 10 or
                                column(4 downto 0) = 11 or --10
                                column(4 downto 0) = 12 or
                                column(4 downto 0) = 13 or
                                column(4 downto 0) = 14 or
                                column(4 downto 0) = 15 or
                                column(4 downto 0) = 16 or
                                column(4 downto 0) = 17 or
                                column(4 downto 0) = 18 or
                                column(4 downto 0) = 19 or
                                column(4 downto 0) = 20 or
                                column(4 downto 0) = 21 or
                                column(4 downto 0) = 22 or
                                column(4 downto 0) = 23 or
                                column(4 downto 0) = 24 or
                                column(4 downto 0) = 25 or
                                column(4 downto 0) = 26 or
                                column(4 downto 0) = 27 or
                                column(4 downto 0) = 28 or
                                column(4 downto 0) = 29 or
                                column(4 downto 0) = 30 or
                                column(4 downto 0) = 31
                                
                                )
                                )
                                -----------END BORDER-------------------------
                                      
                                    
                            )
                    else '0'; 


ten <= '1' when (ch1(4 downto 0) = "01110") and 
                            (
                                ((
                                    row(4 downto 0) = 4 or
                                    row(4 downto 0) = 5 or
                                    row(4 downto 0) = 6 or
                                    row(4 downto 0) = 7 or
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001" or
                                    row(4 downto 0) = "10010" or
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101" or
                                    row(4 downto 0) = "10110" or
                                    row(4 downto 0) = "10111" or
                                    row(4 downto 0) = "11000" or
                                    row(4 downto 0) = "11001" or
                                    row(4 downto 0) = "11010" or
                                    row(4 downto 0) = "11011"
    
                                )
                                 and
                                (
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" 
                                )
                            ) 
                            or
                            (
                                ((
                                    row(4 downto 0) = 4 or
                                    row(4 downto 0) = 5 or
                                    row(4 downto 0) = 6 or
                                    row(4 downto 0) = 7 or
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001" or
                                    row(4 downto 0) = "10010" or
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101" or
                                    row(4 downto 0) = "10110" or
                                    row(4 downto 0) = "10111" or
                                    row(4 downto 0) = "11000" or
                                    row(4 downto 0) = "11001" or
                                    row(4 downto 0) = "11010" or
                                    row(4 downto 0) = "11011"
                                )
                                and
                                (
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = 4 or
                                    row(4 downto 0) = 5 or
                                    row(4 downto 0) = 6 or
                                    row(4 downto 0) = 7 or
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001" or
                                    row(4 downto 0) = "10010" or
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101" or
                                    row(4 downto 0) = "10110" or
                                    row(4 downto 0) = "10111" or
                                    row(4 downto 0) = "11000" or
                                    row(4 downto 0) = "11001" or
                                    row(4 downto 0) = "11010" or
                                    row(4 downto 0) = "11011" 
                                )
                                and
                                (
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111" or
                                    column(4 downto 0) = "11000"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = 4 or
                                    row(4 downto 0) = 5 or
                                    row(4 downto 0) = 6 or
                                    row(4 downto 0) = 7
                                )
                                and
                                (
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = 24 or
                                    row(4 downto 0) = "11001" or
                                    row(4 downto 0) = "11010" or
                                    row(4 downto 0) = "11011"
                            )
                                and
                                (
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100"
    
                                ))
                            )
                                                        or------START BORDER-------------------------
                            (
                            (
                            column(4 downto 0) = 0 or
                            column(4 downto 0) = 31 ---sdgfichazldvjs
                            
                            
                            )
                            and
                            ( ---sefkskv
                            row(4 downto 0) = 0 or
                            row(4 downto 0) = 1 or
                            row(4 downto 0) = 2 or
                            row(4 downto 0) = 3 or
                            row(4 downto 0) = 4 or
                            row(4 downto 0) = 5 or
                            row(4 downto 0) = 6 or
                            row(4 downto 0) = 7 or
                            row(4 downto 0) = 8 or
                            row(4 downto 0) = 9 or
                            row(4 downto 0) = 10 or
                            row(4 downto 0) = 11 or --10
                            row(4 downto 0) = 12 or
                            row(4 downto 0) = 13 or
                            row(4 downto 0) = 14 or
                            row(4 downto 0) = 15 or
                            row(4 downto 0) = 16 or
                            row(4 downto 0) = 17 or
                            row(4 downto 0) = 18 or
                            row(4 downto 0) = 19 or
                            row(4 downto 0) = 20 or
                            row(4 downto 0) = 21 or
                            row(4 downto 0) = 22 or
                            row(4 downto 0) = 23 or
                            row(4 downto 0) = 24 or
                            row(4 downto 0) = 25 or
                            row(4 downto 0) = 26 or
                            row(4 downto 0) = 27 or
                            row(4 downto 0) = 28 or
                            row(4 downto 0) = 29 or
                            row(4 downto 0) = 30 or
                            row(4 downto 0) = 31
                            
                            )
                            )
                            or
                            (
                            (
                            row(4 downto 0) = 0 or
                            row(4 downto 0) = 31 ---sdgfichazldvjs
                            
                            
                            )
                            and
                            ( ---sefkskv
                            column(4 downto 0) = 0 or
                            column(4 downto 0) = 1 or
                            column(4 downto 0) = 2 or
                            column(4 downto 0) = 3 or
                            column(4 downto 0) = 4 or
                            column(4 downto 0) = 5 or
                            column(4 downto 0) = 6 or
                            column(4 downto 0) = 7 or
                            column(4 downto 0) = 8 or
                            column(4 downto 0) = 9 or
                            column(4 downto 0) = 10 or
                            column(4 downto 0) = 11 or --10
                            column(4 downto 0) = 12 or
                            column(4 downto 0) = 13 or
                            column(4 downto 0) = 14 or
                            column(4 downto 0) = 15 or
                            column(4 downto 0) = 16 or
                            column(4 downto 0) = 17 or
                            column(4 downto 0) = 18 or
                            column(4 downto 0) = 19 or
                            column(4 downto 0) = 20 or
                            column(4 downto 0) = 21 or
                            column(4 downto 0) = 22 or
                            column(4 downto 0) = 23 or
                            column(4 downto 0) = 24 or
                            column(4 downto 0) = 25 or
                            column(4 downto 0) = 26 or
                            column(4 downto 0) = 27 or
                            column(4 downto 0) = 28 or
                            column(4 downto 0) = 29 or
                            column(4 downto 0) = 30 or
                            column(4 downto 0) = 31
                            
                            )
                            )
                            -----------END BORDER-------------------------
                          
                                  
                                
                        )
                else '0';    

nine <= '1' when (ch1(4 downto 0) = "01101") and 
                            (
                                ((
                                    row(4 downto 0) = "00100" or
                                    row(4 downto 0) = "00101" or
                                    row(4 downto 0) = "00110" or
                                    row(4 downto 0) = "00111"
    
                                )
                                 and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
                                )
                            ) 
                            or
                            (
                                ((
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001" 
                                )
                                and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "10111" or
                                    row(4 downto 0) = "11000" or
                                    row(4 downto 0) = "11001" or
                                    row(4 downto 0) = "11010" or
                                    row(4 downto 0) = "11011"
                                )
                                and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001" or
                                    row(4 downto 0) = "10010" or
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101" or
                                    row(4 downto 0) = "10110"
                                )
                                and
                                (
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001"
                            )
                                and
                                (
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011"
    
                                ))
                            )
                                                        or------START BORDER-------------------------
                            (
                            (
                            column(4 downto 0) = 0 or
                            column(4 downto 0) = 31 ---sdgfichazldvjs
                            
                            
                            )
                            and
                            ( ---sefkskv
                            row(4 downto 0) = 0 or
                            row(4 downto 0) = 1 or
                            row(4 downto 0) = 2 or
                            row(4 downto 0) = 3 or
                            row(4 downto 0) = 4 or
                            row(4 downto 0) = 5 or
                            row(4 downto 0) = 6 or
                            row(4 downto 0) = 7 or
                            row(4 downto 0) = 8 or
                            row(4 downto 0) = 9 or
                            row(4 downto 0) = 10 or
                            row(4 downto 0) = 11 or --10
                            row(4 downto 0) = 12 or
                            row(4 downto 0) = 13 or
                            row(4 downto 0) = 14 or
                            row(4 downto 0) = 15 or
                            row(4 downto 0) = 16 or
                            row(4 downto 0) = 17 or
                            row(4 downto 0) = 18 or
                            row(4 downto 0) = 19 or
                            row(4 downto 0) = 20 or
                            row(4 downto 0) = 21 or
                            row(4 downto 0) = 22 or
                            row(4 downto 0) = 23 or
                            row(4 downto 0) = 24 or
                            row(4 downto 0) = 25 or
                            row(4 downto 0) = 26 or
                            row(4 downto 0) = 27 or
                            row(4 downto 0) = 28 or
                            row(4 downto 0) = 29 or
                            row(4 downto 0) = 30 or
                            row(4 downto 0) = 31
                            
                            )
                            )
                            or
                            (
                            (
                            row(4 downto 0) = 0 or
                            row(4 downto 0) = 31 ---sdgfichazldvjs
                            
                            
                            )
                            and
                            ( ---sefkskv
                            column(4 downto 0) = 0 or
                            column(4 downto 0) = 1 or
                            column(4 downto 0) = 2 or
                            column(4 downto 0) = 3 or
                            column(4 downto 0) = 4 or
                            column(4 downto 0) = 5 or
                            column(4 downto 0) = 6 or
                            column(4 downto 0) = 7 or
                            column(4 downto 0) = 8 or
                            column(4 downto 0) = 9 or
                            column(4 downto 0) = 10 or
                            column(4 downto 0) = 11 or --10
                            column(4 downto 0) = 12 or
                            column(4 downto 0) = 13 or
                            column(4 downto 0) = 14 or
                            column(4 downto 0) = 15 or
                            column(4 downto 0) = 16 or
                            column(4 downto 0) = 17 or
                            column(4 downto 0) = 18 or
                            column(4 downto 0) = 19 or
                            column(4 downto 0) = 20 or
                            column(4 downto 0) = 21 or
                            column(4 downto 0) = 22 or
                            column(4 downto 0) = 23 or
                            column(4 downto 0) = 24 or
                            column(4 downto 0) = 25 or
                            column(4 downto 0) = 26 or
                            column(4 downto 0) = 27 or
                            column(4 downto 0) = 28 or
                            column(4 downto 0) = 29 or
                            column(4 downto 0) = 30 or
                            column(4 downto 0) = 31
                            
                            )
                            )
                            -----------END BORDER-------------------------
                            
                          
                                  
                                
                        )
                else '0';    

eight <= '1' when (ch1(4 downto 0) = "01100") and 
                            (
                                ((
                                    row(4 downto 0) = "00100" or
                                    row(4 downto 0) = "00101" or
                                    row(4 downto 0) = "00110" or
                                    row(4 downto 0) = "00111"
    
                                )
                                 and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
                                )
                            ) 
                            or
                            (
                                ((
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001" or
                                    row(4 downto 0) = "10010" or
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101" or
                                    row(4 downto 0) = "10110"
                                )
                                and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "10111" or
                                    row(4 downto 0) = "11000" or
                                    row(4 downto 0) = "11001" or
                                    row(4 downto 0) = "11010" or
                                    row(4 downto 0) = "11011"
                                )
                                and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001" or
                                    row(4 downto 0) = "10010" or
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101" or
                                    row(4 downto 0) = "10110"
                                )
                                and
                                (
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001"
                            )
                                and
                                (
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011"
    
                                ))
                            )
                                                        or------START BORDER-------------------------
                            (
                            (
                            column(4 downto 0) = 0 or
                            column(4 downto 0) = 31 ---sdgfichazldvjs
                            
                            
                            )
                            and
                            ( ---sefkskv
                            row(4 downto 0) = 0 or
                            row(4 downto 0) = 1 or
                            row(4 downto 0) = 2 or
                            row(4 downto 0) = 3 or
                            row(4 downto 0) = 4 or
                            row(4 downto 0) = 5 or
                            row(4 downto 0) = 6 or
                            row(4 downto 0) = 7 or
                            row(4 downto 0) = 8 or
                            row(4 downto 0) = 9 or
                            row(4 downto 0) = 10 or
                            row(4 downto 0) = 11 or --10
                            row(4 downto 0) = 12 or
                            row(4 downto 0) = 13 or
                            row(4 downto 0) = 14 or
                            row(4 downto 0) = 15 or
                            row(4 downto 0) = 16 or
                            row(4 downto 0) = 17 or
                            row(4 downto 0) = 18 or
                            row(4 downto 0) = 19 or
                            row(4 downto 0) = 20 or
                            row(4 downto 0) = 21 or
                            row(4 downto 0) = 22 or
                            row(4 downto 0) = 23 or
                            row(4 downto 0) = 24 or
                            row(4 downto 0) = 25 or
                            row(4 downto 0) = 26 or
                            row(4 downto 0) = 27 or
                            row(4 downto 0) = 28 or
                            row(4 downto 0) = 29 or
                            row(4 downto 0) = 30 or
                            row(4 downto 0) = 31
                            
                            )
                            )
                            or
                            (
                            (
                            row(4 downto 0) = 0 or
                            row(4 downto 0) = 31 ---sdgfichazldvjs
                            
                            
                            )
                            and
                            ( ---sefkskv
                            column(4 downto 0) = 0 or
                            column(4 downto 0) = 1 or
                            column(4 downto 0) = 2 or
                            column(4 downto 0) = 3 or
                            column(4 downto 0) = 4 or
                            column(4 downto 0) = 5 or
                            column(4 downto 0) = 6 or
                            column(4 downto 0) = 7 or
                            column(4 downto 0) = 8 or
                            column(4 downto 0) = 9 or
                            column(4 downto 0) = 10 or
                            column(4 downto 0) = 11 or --10
                            column(4 downto 0) = 12 or
                            column(4 downto 0) = 13 or
                            column(4 downto 0) = 14 or
                            column(4 downto 0) = 15 or
                            column(4 downto 0) = 16 or
                            column(4 downto 0) = 17 or
                            column(4 downto 0) = 18 or
                            column(4 downto 0) = 19 or
                            column(4 downto 0) = 20 or
                            column(4 downto 0) = 21 or
                            column(4 downto 0) = 22 or
                            column(4 downto 0) = 23 or
                            column(4 downto 0) = 24 or
                            column(4 downto 0) = 25 or
                            column(4 downto 0) = 26 or
                            column(4 downto 0) = 27 or
                            column(4 downto 0) = 28 or
                            column(4 downto 0) = 29 or
                            column(4 downto 0) = 30 or
                            column(4 downto 0) = 31
                            
                            )
                            )
                            -----------END BORDER-------------------------
                            
                          
                                  
                                
                        )
                else '0';    


    
seven <= '1' when (ch1(4 downto 0) = "01011") and 
                                (
                                    ((
                                        row(4 downto 0) = "00100" or
                                        row(4 downto 0) = "00101" or
                                        row(4 downto 0) = "00110" or
                                        row(4 downto 0) = "00111"
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = "01000" or
                                        column(4 downto 0) = "01001" or
                                        column(4 downto 0) = "01010" or
                                        column(4 downto 0) = "01011" or
                                        column(4 downto 0) = "01100" or
                                        column(4 downto 0) = "01101" or
                                        column(4 downto 0) = "01110" or
                                        column(4 downto 0) = "01111" or
                                        column(4 downto 0) = "10000" or
                                        column(4 downto 0) = "10001" or
                                        column(4 downto 0) = "10010" or
                                        column(4 downto 0) = "10011" or
                                        column(4 downto 0) = "10100" or
                                        column(4 downto 0) = "10101" or
                                        column(4 downto 0) = "10110" or
                                        column(4 downto 0) = "10111"
                                    )
                                ) 
                                or
                                (
                                    ((
                                        row(4 downto 0) = "10010" or
                                        row(4 downto 0) = "10011" or
                                        row(4 downto 0) = "10100" or
                                        row(4 downto 0) = "10101" or
                                        row(4 downto 0) = "10110" or
                                        row(4 downto 0) = "10111" or
                                        row(4 downto 0) = "11000" or
                                        row(4 downto 0) = "11001" or
                                        row(4 downto 0) = "11010" or
                                        row(4 downto 0) = "11011"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "01000" or
                                        column(4 downto 0) = "01001" or
                                        column(4 downto 0) = "01010" or
                                        column(4 downto 0) = "01011" or
                                        column(4 downto 0) = "01100" or
                                        column(4 downto 0) = "01101"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "01000" or
                                        row(4 downto 0) = "01001" or
                                        row(4 downto 0) = "01010" or
                                        row(4 downto 0) = "01011" or
                                        row(4 downto 0) = "01100" or
                                        row(4 downto 0) = "01101" or
                                        row(4 downto 0) = "01110"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "10100" or
                                        column(4 downto 0) = "10101" or
                                        column(4 downto 0) = "10110" or
                                        column(4 downto 0) = "10111"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "01100" or
                                        row(4 downto 0) = "01101" or
                                        row(4 downto 0) = "01110" or
                                        row(4 downto 0) = "01111"
                                    )
                                    and
                                    (
                                        column(4 downto 0) = "10001" or
                                        column(4 downto 0) = "10010" or
                                        column(4 downto 0) = "10011"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "01110" or
                                        row(4 downto 0) = "01111" or
                                        row(4 downto 0) = "10000" or
                                        row(4 downto 0) = "10001"
                                )
                                    and
                                    (
                                        column(4 downto 0) = "01110" or
                                        column(4 downto 0) = "01111" or
                                        column(4 downto 0) = "10000"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "10000" or
                                        row(4 downto 0) = "10001"
                                )
                                    and
                                    (
                                        column(4 downto 0) = "01011" or
                                        column(4 downto 0) = "01100" or
                                        column(4 downto 0) = "01101"
        
                                    ))
                                )
                                or
                                (
                                    ((
                                        row(4 downto 0) = "10010"
                                )
                                    and
                                    (
                                        column(4 downto 0) = "01110"
        
                                    ))
                                )
                                                            or------START BORDER-------------------------
                                (
                                (
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 31 ---sdgfichazldvjs
                                
                                
                                )
                                and
                                ( ---sefkskv
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 1 or
                                row(4 downto 0) = 2 or
                                row(4 downto 0) = 3 or
                                row(4 downto 0) = 4 or
                                row(4 downto 0) = 5 or
                                row(4 downto 0) = 6 or
                                row(4 downto 0) = 7 or
                                row(4 downto 0) = 8 or
                                row(4 downto 0) = 9 or
                                row(4 downto 0) = 10 or
                                row(4 downto 0) = 11 or --10
                                row(4 downto 0) = 12 or
                                row(4 downto 0) = 13 or
                                row(4 downto 0) = 14 or
                                row(4 downto 0) = 15 or
                                row(4 downto 0) = 16 or
                                row(4 downto 0) = 17 or
                                row(4 downto 0) = 18 or
                                row(4 downto 0) = 19 or
                                row(4 downto 0) = 20 or
                                row(4 downto 0) = 21 or
                                row(4 downto 0) = 22 or
                                row(4 downto 0) = 23 or
                                row(4 downto 0) = 24 or
                                row(4 downto 0) = 25 or
                                row(4 downto 0) = 26 or
                                row(4 downto 0) = 27 or
                                row(4 downto 0) = 28 or
                                row(4 downto 0) = 29 or
                                row(4 downto 0) = 30 or
                                row(4 downto 0) = 31
                                
                                )
                                )
                                or
                                (
                                (
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 31 ---sdgfichazldvjs
                                
                                
                                )
                                and
                                ( ---sefkskv
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 1 or
                                column(4 downto 0) = 2 or
                                column(4 downto 0) = 3 or
                                column(4 downto 0) = 4 or
                                column(4 downto 0) = 5 or
                                column(4 downto 0) = 6 or
                                column(4 downto 0) = 7 or
                                column(4 downto 0) = 8 or
                                column(4 downto 0) = 9 or
                                column(4 downto 0) = 10 or
                                column(4 downto 0) = 11 or --10
                                column(4 downto 0) = 12 or
                                column(4 downto 0) = 13 or
                                column(4 downto 0) = 14 or
                                column(4 downto 0) = 15 or
                                column(4 downto 0) = 16 or
                                column(4 downto 0) = 17 or
                                column(4 downto 0) = 18 or
                                column(4 downto 0) = 19 or
                                column(4 downto 0) = 20 or
                                column(4 downto 0) = 21 or
                                column(4 downto 0) = 22 or
                                column(4 downto 0) = 23 or
                                column(4 downto 0) = 24 or
                                column(4 downto 0) = 25 or
                                column(4 downto 0) = 26 or
                                column(4 downto 0) = 27 or
                                column(4 downto 0) = 28 or
                                column(4 downto 0) = 29 or
                                column(4 downto 0) = 30 or
                                column(4 downto 0) = 31
                                
                                )
                                )
                                -----------END BORDER-------------------------
                                
                              
                                      
                                    
                            )
                    else '0';

six <= '1' when (ch1(4 downto 0) = "01010") and 
                            (
                                ((
                                    row(4 downto 0) = "00100" or
                                    row(4 downto 0) = "00101" or
                                    row(4 downto 0) = "00110" or
                                    row(4 downto 0) = "00111"
    
                                )
                                 and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
                                )
                            ) 
                            or
                            (
                                ((
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001" or
                                    row(4 downto 0) = "10010" or
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101" or
                                    row(4 downto 0) = "10110" or
                                    row(4 downto 0) = "10111"
                                )
                                and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "10111" or
                                    row(4 downto 0) = "11000" or
                                    row(4 downto 0) = "11001" or
                                    row(4 downto 0) = "11010" or
                                    row(4 downto 0) = "11011"
                                )
                                and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001"
                                )
                                and
                                (
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001" or
                                    row(4 downto 0) = "10010" or
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101" or
                                    row(4 downto 0) = "10110" 
                            )
                                and
                                (
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
    
                                ))
                            )
                                                        or------START BORDER-------------------------
                            (
                            (
                            column(4 downto 0) = 0 or
                            column(4 downto 0) = 31 ---sdgfichazldvjs
                            
                            
                            )
                            and
                            ( ---sefkskv
                            row(4 downto 0) = 0 or
                            row(4 downto 0) = 1 or
                            row(4 downto 0) = 2 or
                            row(4 downto 0) = 3 or
                            row(4 downto 0) = 4 or
                            row(4 downto 0) = 5 or
                            row(4 downto 0) = 6 or
                            row(4 downto 0) = 7 or
                            row(4 downto 0) = 8 or
                            row(4 downto 0) = 9 or
                            row(4 downto 0) = 10 or
                            row(4 downto 0) = 11 or --10
                            row(4 downto 0) = 12 or
                            row(4 downto 0) = 13 or
                            row(4 downto 0) = 14 or
                            row(4 downto 0) = 15 or
                            row(4 downto 0) = 16 or
                            row(4 downto 0) = 17 or
                            row(4 downto 0) = 18 or
                            row(4 downto 0) = 19 or
                            row(4 downto 0) = 20 or
                            row(4 downto 0) = 21 or
                            row(4 downto 0) = 22 or
                            row(4 downto 0) = 23 or
                            row(4 downto 0) = 24 or
                            row(4 downto 0) = 25 or
                            row(4 downto 0) = 26 or
                            row(4 downto 0) = 27 or
                            row(4 downto 0) = 28 or
                            row(4 downto 0) = 29 or
                            row(4 downto 0) = 30 or
                            row(4 downto 0) = 31
                            
                            )
                            )
                            or
                            (
                            (
                            row(4 downto 0) = 0 or
                            row(4 downto 0) = 31 ---sdgfichazldvjs
                            
                            
                            )
                            and
                            ( ---sefkskv
                            column(4 downto 0) = 0 or
                            column(4 downto 0) = 1 or
                            column(4 downto 0) = 2 or
                            column(4 downto 0) = 3 or
                            column(4 downto 0) = 4 or
                            column(4 downto 0) = 5 or
                            column(4 downto 0) = 6 or
                            column(4 downto 0) = 7 or
                            column(4 downto 0) = 8 or
                            column(4 downto 0) = 9 or
                            column(4 downto 0) = 10 or
                            column(4 downto 0) = 11 or --10
                            column(4 downto 0) = 12 or
                            column(4 downto 0) = 13 or
                            column(4 downto 0) = 14 or
                            column(4 downto 0) = 15 or
                            column(4 downto 0) = 16 or
                            column(4 downto 0) = 17 or
                            column(4 downto 0) = 18 or
                            column(4 downto 0) = 19 or
                            column(4 downto 0) = 20 or
                            column(4 downto 0) = 21 or
                            column(4 downto 0) = 22 or
                            column(4 downto 0) = 23 or
                            column(4 downto 0) = 24 or
                            column(4 downto 0) = 25 or
                            column(4 downto 0) = 26 or
                            column(4 downto 0) = 27 or
                            column(4 downto 0) = 28 or
                            column(4 downto 0) = 29 or
                            column(4 downto 0) = 30 or
                            column(4 downto 0) = 31
                            
                            )
                            )
                            -----------END BORDER-------------------------
                            
                          
                                  
                                
                        )
                else '0';


five <= '1' when (ch1(4 downto 0) = "01001") and 
                            (
                                ((
                                    row(4 downto 0) = "00100" or
                                    row(4 downto 0) = "00101" or
                                    row(4 downto 0) = "00110" or
                                    row(4 downto 0) = "00111"
    
                                )
                                 and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
                                )
                            ) 
                            or
                            (
                                ((
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000"
                                )
                                and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "10001" or
                                    row(4 downto 0) = "10010"
                                )
                                and
                                (
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "10110" or
                                    row(4 downto 0) = "10111" or
                                    row(4 downto 0) = "11000" or
                                    row(4 downto 0) = "11001" or
                                    row(4 downto 0) = "11010" or
                                    row(4 downto 0) = "11011" 
                                )
                                and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101"
    
                                ))
                            )
                            or
                            (
                                ((
                                    column(4 downto 0) = "10111"
                                )
                                and
                                (
                                    row(4 downto 0) = "10101" or
                                    row(4 downto 0) = "10110" or
                                    row(4 downto 0) = "10111" or
                                    row(4 downto 0) = "11000" or
                                    row(4 downto 0) = "11001"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000"
                            )
                                and
                                (
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000"
    
                                ))
                            )
                            or
                            (
                                ((
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
                            )
                                and
                                (
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101"
    
                                ))
                            )
                            or
                            (
                                ((
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110"
                                )
                                and
                                (
                                    row(4 downto 0) = "10010"
    
                                ))
                            )
                          or
                              (
                                  ((
                                      row(4 downto 0) = "01111"
                                  )
                                  and
                                  (
                                      column(4 downto 0) = "10001" or
                                      column(4 downto 0) = "10010" or
                                      column(4 downto 0) = "10011"
      
                                  ))
                              )
                          or
                              (
                                  ((
                                      column(4 downto 0) = "10101" or
                                      column(4 downto 0) = "10110"
                                  )
                                  and
                                  (
                                        row(4 downto 0) = "10110" or
                                        row(4 downto 0) = "10111" or
                                        row(4 downto 0) = "11000" or
                                        row(4 downto 0) = "11001" or
                                        row(4 downto 0) = "11010"
      
                                  ))
                              )
                          or
                              (
                                  ((
                                      column(4 downto 0) = "10001" or
                                      column(4 downto 0) = "10010" or
                                      column(4 downto 0) = "10011" or
                                      column(4 downto 0) = "10100"
                                  )
                                  and
                                  (
                                      row(4 downto 0) = "10000" or
                                      row(4 downto 0) = "10001" or
                                      row(4 downto 0) = "10010"
      
                                  ))
                              )
                                                          or------START BORDER-------------------------
                              (
                              (
                              column(4 downto 0) = 0 or
                              column(4 downto 0) = 31 ---sdgfichazldvjs
                              
                              
                              )
                              and
                              ( ---sefkskv
                              row(4 downto 0) = 0 or
                              row(4 downto 0) = 1 or
                              row(4 downto 0) = 2 or
                              row(4 downto 0) = 3 or
                              row(4 downto 0) = 4 or
                              row(4 downto 0) = 5 or
                              row(4 downto 0) = 6 or
                              row(4 downto 0) = 7 or
                              row(4 downto 0) = 8 or
                              row(4 downto 0) = 9 or
                              row(4 downto 0) = 10 or
                              row(4 downto 0) = 11 or --10
                              row(4 downto 0) = 12 or
                              row(4 downto 0) = 13 or
                              row(4 downto 0) = 14 or
                              row(4 downto 0) = 15 or
                              row(4 downto 0) = 16 or
                              row(4 downto 0) = 17 or
                              row(4 downto 0) = 18 or
                              row(4 downto 0) = 19 or
                              row(4 downto 0) = 20 or
                              row(4 downto 0) = 21 or
                              row(4 downto 0) = 22 or
                              row(4 downto 0) = 23 or
                              row(4 downto 0) = 24 or
                              row(4 downto 0) = 25 or
                              row(4 downto 0) = 26 or
                              row(4 downto 0) = 27 or
                              row(4 downto 0) = 28 or
                              row(4 downto 0) = 29 or
                              row(4 downto 0) = 30 or
                              row(4 downto 0) = 31
                              
                              )
                              )
                              or
                              (
                              (
                              row(4 downto 0) = 0 or
                              row(4 downto 0) = 31 ---sdgfichazldvjs
                              
                              
                              )
                              and
                              ( ---sefkskv
                              column(4 downto 0) = 0 or
                              column(4 downto 0) = 1 or
                              column(4 downto 0) = 2 or
                              column(4 downto 0) = 3 or
                              column(4 downto 0) = 4 or
                              column(4 downto 0) = 5 or
                              column(4 downto 0) = 6 or
                              column(4 downto 0) = 7 or
                              column(4 downto 0) = 8 or
                              column(4 downto 0) = 9 or
                              column(4 downto 0) = 10 or
                              column(4 downto 0) = 11 or --10
                              column(4 downto 0) = 12 or
                              column(4 downto 0) = 13 or
                              column(4 downto 0) = 14 or
                              column(4 downto 0) = 15 or
                              column(4 downto 0) = 16 or
                              column(4 downto 0) = 17 or
                              column(4 downto 0) = 18 or
                              column(4 downto 0) = 19 or
                              column(4 downto 0) = 20 or
                              column(4 downto 0) = 21 or
                              column(4 downto 0) = 22 or
                              column(4 downto 0) = 23 or
                              column(4 downto 0) = 24 or
                              column(4 downto 0) = 25 or
                              column(4 downto 0) = 26 or
                              column(4 downto 0) = 27 or
                              column(4 downto 0) = 28 or
                              column(4 downto 0) = 29 or
                              column(4 downto 0) = 30 or
                              column(4 downto 0) = 31
                              
                              )
                              )
                              -----------END BORDER-------------------------
                          
                                  
                                
                        )
                else '0';

four <= '1' when (ch1(4 downto 0) = "01000") and 
                            (
                                ((
                                    row(4 downto 0) = "00100" or
                                    row(4 downto 0) = "00101" or
                                    row(4 downto 0) = "00110" or
                                    row(4 downto 0) = "00111" or
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001"
    
                                )
                                 and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" 
                                )
                            ) 
                            or
                            (
                                ((
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001"
                                )
                                and
                                (
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" 
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "00111" or
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001" or
                                    row(4 downto 0) = "10010" or
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101" or
                                    row(4 downto 0) = "10110" or
                                    row(4 downto 0) = "10111" or
                                    row(4 downto 0) = "11000" or
                                    row(4 downto 0) = "11001" or
                                    row(4 downto 0) = "11010" or
                                    row(4 downto 0) = "11011"
                                )
                                and
                                (
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100"
    
                                ))
                            )
                            or
                            (
                                ((
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
                                )
                                and
                                (
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001" 
    
                                ))
                            )
                            or------START BORDER-------------------------
                            (
                            (
                            column(4 downto 0) = 0 or
                            column(4 downto 0) = 31 ---sdgfichazldvjs
                            
                            
                            )
                            and
                            ( ---sefkskv
                            row(4 downto 0) = 0 or
                            row(4 downto 0) = 1 or
                            row(4 downto 0) = 2 or
                            row(4 downto 0) = 3 or
                            row(4 downto 0) = 4 or
                            row(4 downto 0) = 5 or
                            row(4 downto 0) = 6 or
                            row(4 downto 0) = 7 or
                            row(4 downto 0) = 8 or
                            row(4 downto 0) = 9 or
                            row(4 downto 0) = 10 or
                            row(4 downto 0) = 11 or --10
                            row(4 downto 0) = 12 or
                            row(4 downto 0) = 13 or
                            row(4 downto 0) = 14 or
                            row(4 downto 0) = 15 or
                            row(4 downto 0) = 16 or
                            row(4 downto 0) = 17 or
                            row(4 downto 0) = 18 or
                            row(4 downto 0) = 19 or
                            row(4 downto 0) = 20 or
                            row(4 downto 0) = 21 or
                            row(4 downto 0) = 22 or
                            row(4 downto 0) = 23 or
                            row(4 downto 0) = 24 or
                            row(4 downto 0) = 25 or
                            row(4 downto 0) = 26 or
                            row(4 downto 0) = 27 or
                            row(4 downto 0) = 28 or
                            row(4 downto 0) = 29 or
                            row(4 downto 0) = 30 or
                            row(4 downto 0) = 31
                            
                            )
                            )
                            or
                            (
                            (
                            row(4 downto 0) = 0 or
                            row(4 downto 0) = 31 ---sdgfichazldvjs
                            
                            
                            )
                            and
                            ( ---sefkskv
                            column(4 downto 0) = 0 or
                            column(4 downto 0) = 1 or
                            column(4 downto 0) = 2 or
                            column(4 downto 0) = 3 or
                            column(4 downto 0) = 4 or
                            column(4 downto 0) = 5 or
                            column(4 downto 0) = 6 or
                            column(4 downto 0) = 7 or
                            column(4 downto 0) = 8 or
                            column(4 downto 0) = 9 or
                            column(4 downto 0) = 10 or
                            column(4 downto 0) = 11 or --10
                            column(4 downto 0) = 12 or
                            column(4 downto 0) = 13 or
                            column(4 downto 0) = 14 or
                            column(4 downto 0) = 15 or
                            column(4 downto 0) = 16 or
                            column(4 downto 0) = 17 or
                            column(4 downto 0) = 18 or
                            column(4 downto 0) = 19 or
                            column(4 downto 0) = 20 or
                            column(4 downto 0) = 21 or
                            column(4 downto 0) = 22 or
                            column(4 downto 0) = 23 or
                            column(4 downto 0) = 24 or
                            column(4 downto 0) = 25 or
                            column(4 downto 0) = 26 or
                            column(4 downto 0) = 27 or
                            column(4 downto 0) = 28 or
                            column(4 downto 0) = 29 or
                            column(4 downto 0) = 30 or
                            column(4 downto 0) = 31
                            
                            )
                            )
                            -----------END BORDER-------------------------
                            
                                  
                                
                        )
                else '0';

three <= '1' when (ch1(4 downto 0) = "00111") and 
                                ((
(
column(4 downto 0) = 8 or
column(4 downto 0) = 9 or
column(4 downto 0) = 10 or
column(4 downto 0) = 11 or --10
column(4 downto 0) = 12 or
column(4 downto 0) = 13 or
column(4 downto 0) = 14 or
column(4 downto 0) = 15 or
column(4 downto 0) = 16 or
column(4 downto 0) = 17 or
column(4 downto 0) = 18 or
column(4 downto 0) = 19 or
column(4 downto 0) = 20 or
column(4 downto 0) = 21 or
column(4 downto 0) = 22 or
column(4 downto 0) = 23


)
and
(
row(4 downto 0) = 5 or
row(4 downto 0) = 6 or
row(4 downto 0) = 7 or
row(4 downto 0) = 8 or
row(4 downto 0) = 24 or
row(4 downto 0) = 25 or
row(4 downto 0) = 26 or --10
row(4 downto 0) = 27

)
)
or
(
( --s-fdgvfsdv
row(4 downto 0) = 13 or
row(4 downto 0) = 14 or
row(4 downto 0) = 15 or
row(4 downto 0) = 16


)
and
(
column(4 downto 0) = 14 or
column(4 downto 0) = 15 or
column(4 downto 0) = 16 or
column(4 downto 0) = 17 or
column(4 downto 0) = 18 or
column(4 downto 0) = 19 

)
)
or
(
(
column(4 downto 0) = 20 or
column(4 downto 0) = 21 or
column(4 downto 0) = 22 or
column(4 downto 0) = 23



)
and
( ---sefkskv
row(4 downto 0) = 5 or
row(4 downto 0) = 6 or
row(4 downto 0) = 7 or
row(4 downto 0) = 8 or
row(4 downto 0) = 9 or
row(4 downto 0) = 10 or
row(4 downto 0) = 11 or --10
row(4 downto 0) = 12 or
row(4 downto 0) = 13 or
row(4 downto 0) = 14 or
row(4 downto 0) = 15 or
row(4 downto 0) = 16 or
row(4 downto 0) = 17  or 
row(4 downto 0) = 18 or
row(4 downto 0) = 19 or
row(4 downto 0) = 20 or
row(4 downto 0) = 21 or
row(4 downto 0) = 22 or
row(4 downto 0) = 23 or
row(4 downto 0) = 24 or
row(4 downto 0) = 25 or
row(4 downto 0) = 26 or
row(4 downto 0) = 27


)
)
or
------START BORDER-------------------------
(
(
column(4 downto 0) = 0 or
column(4 downto 0) = 31 ---sdgfichazldvjs


)
and
( ---sefkskv
row(4 downto 0) = 0 or
row(4 downto 0) = 1 or
row(4 downto 0) = 2 or
row(4 downto 0) = 3 or
row(4 downto 0) = 4 or
row(4 downto 0) = 5 or
row(4 downto 0) = 6 or
row(4 downto 0) = 7 or
row(4 downto 0) = 8 or
row(4 downto 0) = 9 or
row(4 downto 0) = 10 or
row(4 downto 0) = 11 or --10
row(4 downto 0) = 12 or
row(4 downto 0) = 13 or
row(4 downto 0) = 14 or
row(4 downto 0) = 15 or
row(4 downto 0) = 16 or
row(4 downto 0) = 17 or
row(4 downto 0) = 18 or
row(4 downto 0) = 19 or
row(4 downto 0) = 20 or
row(4 downto 0) = 21 or
row(4 downto 0) = 22 or
row(4 downto 0) = 23 or
row(4 downto 0) = 24 or
row(4 downto 0) = 25 or
row(4 downto 0) = 26 or
row(4 downto 0) = 27 or
row(4 downto 0) = 28 or
row(4 downto 0) = 29 or
row(4 downto 0) = 30 or
row(4 downto 0) = 31

)
)
or
(
(
row(4 downto 0) = 0 or
row(4 downto 0) = 31 ---sdgfichazldvjs


)
and
( ---sefkskv
column(4 downto 0) = 0 or
column(4 downto 0) = 1 or
column(4 downto 0) = 2 or
column(4 downto 0) = 3 or
column(4 downto 0) = 4 or
column(4 downto 0) = 5 or
column(4 downto 0) = 6 or
column(4 downto 0) = 7 or
column(4 downto 0) = 8 or
column(4 downto 0) = 9 or
column(4 downto 0) = 10 or
column(4 downto 0) = 11 or --10
column(4 downto 0) = 12 or
column(4 downto 0) = 13 or
column(4 downto 0) = 14 or
column(4 downto 0) = 15 or
column(4 downto 0) = 16 or
column(4 downto 0) = 17 or
column(4 downto 0) = 18 or
column(4 downto 0) = 19 or
column(4 downto 0) = 20 or
column(4 downto 0) = 21 or
column(4 downto 0) = 22 or
column(4 downto 0) = 23 or
column(4 downto 0) = 24 or
column(4 downto 0) = 25 or
column(4 downto 0) = 26 or
column(4 downto 0) = 27 or
column(4 downto 0) = 28 or
column(4 downto 0) = 29 or
column(4 downto 0) = 30 or
column(4 downto 0) = 31

)
)
-----------END BORDER--------------------------
    

)
else '0';

two <= '1' when (ch1(4 downto 0) = "00110") and 
                            (
                                ((
                                    row(4 downto 0) = "10110" or
                                    row(4 downto 0) = "10111" or
                                    row(4 downto 0) = "11000" or
                                    row(4 downto 0) = "11001" or
                                    row(4 downto 0) = "11010" or
                                    row(4 downto 0) = "11011"
    
                                )
                                 and
                                (
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
                                )
                            ) 
                            or
                            (
                                ((
                                    row(4 downto 0) = "10010" or
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101"
                                )
                                and
                                (
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001"
                                )
                                and
                                (
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101"
    
                                ))
                            )
                            or
                            (
                                ((
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
                                )
                                and
                                (
                                    row(4 downto 0) = "00100" or
                                    row(4 downto 0) = "00101" or
                                    row(4 downto 0) = "00110" or
                                    row(4 downto 0) = "00111"
    
                                ))
                            )
                            or
                            (
                                ((
                                    column(4 downto 0) = "01000"
                                )
                                and
                                (
                                    row(4 downto 0) = "00110" or
                                    row(4 downto 0) = "00111"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "00101" or
                                    row(4 downto 0) = "00110" or
                                    row(4 downto 0) = "00111"
                            )
                                and
                                (
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "01010"
    
                                ))
                            )
                            or
                            (
                                ((
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" or
                                    column(4 downto 0) = "10110" or
                                    column(4 downto 0) = "10111"
                            )
                                and
                                (
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110"
    
                                ))
                            )
                            or
                            (
                                ((
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011"
                                )
                                and
                                (
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111"
    
                                ))
                            )
                          or
                              (
                                  ((
                                      column(4 downto 0) = "01110" or
                                      column(4 downto 0) = "01111" or
                                      column(4 downto 0) = "10000"
                                  )
                                  and
                                  (
                                      row(4 downto 0) = "01110" or
                                      row(4 downto 0) = "01111" or
                                      row(4 downto 0) = "10000" or
                                      row(4 downto 0) = "10001"
      
                                  ))
                              )
                              or
                              ------START BORDER-------------------------
                              (
                              (
                              column(4 downto 0) = 0 or
                              column(4 downto 0) = 31 ---sdgfichazldvjs
                              
                              
                              )
                              and
                              ( ---sefkskv
                              row(4 downto 0) = 0 or
                              row(4 downto 0) = 1 or
                              row(4 downto 0) = 2 or
                              row(4 downto 0) = 3 or
                              row(4 downto 0) = 4 or
                              row(4 downto 0) = 5 or
                              row(4 downto 0) = 6 or
                              row(4 downto 0) = 7 or
                              row(4 downto 0) = 8 or
                              row(4 downto 0) = 9 or
                              row(4 downto 0) = 10 or
                              row(4 downto 0) = 11 or --10
                              row(4 downto 0) = 12 or
                              row(4 downto 0) = 13 or
                              row(4 downto 0) = 14 or
                              row(4 downto 0) = 15 or
                              row(4 downto 0) = 16 or
                              row(4 downto 0) = 17 or
                              row(4 downto 0) = 18 or
                              row(4 downto 0) = 19 or
                              row(4 downto 0) = 20 or
                              row(4 downto 0) = 21 or
                              row(4 downto 0) = 22 or
                              row(4 downto 0) = 23 or
                              row(4 downto 0) = 24 or
                              row(4 downto 0) = 25 or
                              row(4 downto 0) = 26 or
                              row(4 downto 0) = 27 or
                              row(4 downto 0) = 28 or
                              row(4 downto 0) = 29 or
                              row(4 downto 0) = 30 or
                              row(4 downto 0) = 31
                              
                              )
                              )
                              or
                              (
                              (
                              row(4 downto 0) = 0 or
                              row(4 downto 0) = 31 ---sdgfichazldvjs
                              
                              
                              )
                              and
                              ( ---sefkskv
                              column(4 downto 0) = 0 or
                              column(4 downto 0) = 1 or
                              column(4 downto 0) = 2 or
                              column(4 downto 0) = 3 or
                              column(4 downto 0) = 4 or
                              column(4 downto 0) = 5 or
                              column(4 downto 0) = 6 or
                              column(4 downto 0) = 7 or
                              column(4 downto 0) = 8 or
                              column(4 downto 0) = 9 or
                              column(4 downto 0) = 10 or
                              column(4 downto 0) = 11 or --10
                              column(4 downto 0) = 12 or
                              column(4 downto 0) = 13 or
                              column(4 downto 0) = 14 or
                              column(4 downto 0) = 15 or
                              column(4 downto 0) = 16 or
                              column(4 downto 0) = 17 or
                              column(4 downto 0) = 18 or
                              column(4 downto 0) = 19 or
                              column(4 downto 0) = 20 or
                              column(4 downto 0) = 21 or
                              column(4 downto 0) = 22 or
                              column(4 downto 0) = 23 or
                              column(4 downto 0) = 24 or
                              column(4 downto 0) = 25 or
                              column(4 downto 0) = 26 or
                              column(4 downto 0) = 27 or
                              column(4 downto 0) = 28 or
                              column(4 downto 0) = 29 or
                              column(4 downto 0) = 30 or
                              column(4 downto 0) = 31
                              
                              )
                              )
                              -----------END BORDER-------------------------
                                  
                                
                        )
                else '0';


ace <= '1' when (ch1(4 downto 0) = "00101") and 
                            (
                                ((
                                    row(4 downto 0) = "01101" or
                                    row(4 downto 0) = "01110" or
                                    row(4 downto 0) = "01111" or
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001" or
                                    row(4 downto 0) = "10010" or
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101" or
                                    row(4 downto 0) = "10110" or
                                    row(4 downto 0) = "10111" or
                                    row(4 downto 0) = "11000" or
                                    row(4 downto 0) = "11001" or
                                    row(4 downto 0) = "11010" or
                                    row(4 downto 0) = "11011"
    
                                )
                                 and
                                (
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101" 
                                )
                            ) 
                            or
                            (
                                ((
                                    row(4 downto 0) = "00110" or
                                    row(4 downto 0) = "00111" or
                                    row(4 downto 0) = "01000" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01001" or
                                    row(4 downto 0) = "01010" or
                                    row(4 downto 0) = "01011" or
                                    row(4 downto 0) = "01100" or
                                    row(4 downto 0) = "01101"
                                )
                                and
                                (
                                    column(4 downto 0) = "01010" or
                                    column(4 downto 0) = "01011" or
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011" or
                                    column(4 downto 0) = "10100" or
                                    column(4 downto 0) = "10101"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "00110" or
                                    row(4 downto 0) = "00111" or
                                    row(4 downto 0) = "01000"
                                )
                                and
                                (
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001"
    
                                ))
                            )
                            or
                            (
                                ((
                                    column(4 downto 0) = "01100" or
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010" or
                                    column(4 downto 0) = "10011"
                                )
                                and
                                (
                                    row(4 downto 0) = "00100" or
                                    row(4 downto 0) = "00101"
    
                                ))
                            )
                            or
                            (
                                ((
                                    row(4 downto 0) = "01001"
                                )
                                and
                                (
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "10001"
    
                                ))
                            )
                            or
                            (
                                ((
                                    column(4 downto 0) = "01101" or
                                    column(4 downto 0) = "01110" or
                                    column(4 downto 0) = "01111" or
                                    column(4 downto 0) = "10000" or
                                    column(4 downto 0) = "10001" or
                                    column(4 downto 0) = "10010"
                            )
                                and
                                (
                                    row(4 downto 0) = "10000" or
                                    row(4 downto 0) = "10001"
    
                                ))
                            )
                            or
                            (
                                ((
                                    column(4 downto 0) = "01001" or
                                    column(4 downto 0) = "10110"
                            )
                                and
                                (
                                    row(4 downto 0) = "10010" or
                                    row(4 downto 0) = "10011" or
                                    row(4 downto 0) = "10100" or
                                    row(4 downto 0) = "10101" or
                                    row(4 downto 0) = "10110" or
                                    row(4 downto 0) = "10111" or
                                    row(4 downto 0) = "11000" or
                                    row(4 downto 0) = "11001" or
                                    row(4 downto 0) = "11010" or
                                    row(4 downto 0) = "11011"
    
                                ))
                            )
                            or
                            (
                                ((
                                    column(4 downto 0) = "01000" or
                                    column(4 downto 0) = "10111"
                                )
                                and
                                (
                                    row(4 downto 0) = "11000" or
                                    row(4 downto 0) = "11001" or
                                    row(4 downto 0) = "11010" or
                                    row(4 downto 0) = "11011"
    
                                ))
                            )
                            or
                            ------START BORDER-------------------------
                            (
                            (
                            column(4 downto 0) = 0 or
                            column(4 downto 0) = 31 ---sdgfichazldvjs
                            
                            
                            )
                            and
                            ( ---sefkskv
                            row(4 downto 0) = 0 or
                            row(4 downto 0) = 1 or
                            row(4 downto 0) = 2 or
                            row(4 downto 0) = 3 or
                            row(4 downto 0) = 4 or
                            row(4 downto 0) = 5 or
                            row(4 downto 0) = 6 or
                            row(4 downto 0) = 7 or
                            row(4 downto 0) = 8 or
                            row(4 downto 0) = 9 or
                            row(4 downto 0) = 10 or
                            row(4 downto 0) = 11 or --10
                            row(4 downto 0) = 12 or
                            row(4 downto 0) = 13 or
                            row(4 downto 0) = 14 or
                            row(4 downto 0) = 15 or
                            row(4 downto 0) = 16 or
                            row(4 downto 0) = 17 or
                            row(4 downto 0) = 18 or
                            row(4 downto 0) = 19 or
                            row(4 downto 0) = 20 or
                            row(4 downto 0) = 21 or
                            row(4 downto 0) = 22 or
                            row(4 downto 0) = 23 or
                            row(4 downto 0) = 24 or
                            row(4 downto 0) = 25 or
                            row(4 downto 0) = 26 or
                            row(4 downto 0) = 27 or
                            row(4 downto 0) = 28 or
                            row(4 downto 0) = 29 or
                            row(4 downto 0) = 30 or
                            row(4 downto 0) = 31
                            
                            )
                            )
                            or
                            (
                            (
                            row(4 downto 0) = 0 or
                            row(4 downto 0) = 31 ---sdgfichazldvjs
                            
                            
                            )
                            and
                            ( ---sefkskv
                            column(4 downto 0) = 0 or
                            column(4 downto 0) = 1 or
                            column(4 downto 0) = 2 or
                            column(4 downto 0) = 3 or
                            column(4 downto 0) = 4 or
                            column(4 downto 0) = 5 or
                            column(4 downto 0) = 6 or
                            column(4 downto 0) = 7 or
                            column(4 downto 0) = 8 or
                            column(4 downto 0) = 9 or
                            column(4 downto 0) = 10 or
                            column(4 downto 0) = 11 or --10
                            column(4 downto 0) = 12 or
                            column(4 downto 0) = 13 or
                            column(4 downto 0) = 14 or
                            column(4 downto 0) = 15 or
                            column(4 downto 0) = 16 or
                            column(4 downto 0) = 17 or
                            column(4 downto 0) = 18 or
                            column(4 downto 0) = 19 or
                            column(4 downto 0) = 20 or
                            column(4 downto 0) = 21 or
                            column(4 downto 0) = 22 or
                            column(4 downto 0) = 23 or
                            column(4 downto 0) = 24 or
                            column(4 downto 0) = 25 or
                            column(4 downto 0) = 26 or
                            column(4 downto 0) = 27 or
                            column(4 downto 0) = 28 or
                            column(4 downto 0) = 29 or
                            column(4 downto 0) = 30 or
                            column(4 downto 0) = 31
                            
                            )
                            )
                            -----------END BORDER-------------------------
                                  
                                
                        )
                else '0';




          
spades <= '1' when (ch1(4 downto 0) = "00100") and
                                ((
                                    (
                                        column(4 downto 0) = "01111" or
                                        column(4 downto 0) = "10000"
                                        
        
                                    )
                                     and
                                    (
                                        row(4 downto 0) = "000101" 

                                    )
                                )
                                or
                                (
                                    ( --s-fdgvfsdv
                                    row(4 downto 0) = 4 or
                                    row(4 downto 0) = 5 or
                                    row(4 downto 0) = 6 or
                                    row(4 downto 0) = 7 or
                                    row(4 downto 0) = 8 or
                                    row(4 downto 0) = 9 or
                                    row(4 downto 0) = 10 or
                                    row(4 downto 0) = 11 or --10
                                    row(4 downto 0) = 12 or
                                    row(4 downto 0) = 13 or
                                    row(4 downto 0) = 14 or
                                    row(4 downto 0) = 15 or
                                    row(4 downto 0) = 16 or
                                    row(4 downto 0) = 17 or
                                    row(4 downto 0) = 18 or
                                    row(4 downto 0) = 19 or
                                    row(4 downto 0) = 20 or
                                    row(4 downto 0) = 21 or
                                    row(4 downto 0) = 22 or -- 10
                                    row(4 downto 0) = 23 or
                                    row(4 downto 0) = 24 or
                                    row(4 downto 0) = 25 or
                                    row(4 downto 0) = 26 or
                                    row(4 downto 0) = 27 or
                                    row(4 downto 0) = 28 or
                                    row(4 downto 0) = 29
                                        
        
                                    )
                                     and
                                    (
                                        column(4 downto 0) = 14 or
                                        column(4 downto 0) = 15 or
                                        column(4 downto 0) = 16 or
                                        column(4 downto 0) = 17

                                    )
                                )
                                or
                                (
                                    (
                                        column(4 downto 0) = 13 or
                                        column(4 downto 0) = 18
                                        
        
                                    )
                                     and
                                    ( ---sefkskv

                                    row(4 downto 0) = 5 or
                                    row(4 downto 0) = 6 or
                                    row(4 downto 0) = 7 or
                                    row(4 downto 0) = 8 or
                                    row(4 downto 0) = 9 or
                                    row(4 downto 0) = 10 or
                                    row(4 downto 0) = 11 or --10
                                    row(4 downto 0) = 12 or
                                    row(4 downto 0) = 13 or
                                    row(4 downto 0) = 14 or
                                    row(4 downto 0) = 15 or
                                    row(4 downto 0) = 16 or
                                    row(4 downto 0) = 17 or
                                    
                                    row(4 downto 0) = 24 or
                                    row(4 downto 0) = 25 or
                                    row(4 downto 0) = 26 or
                                    row(4 downto 0) = 27 or
                                    row(4 downto 0) = 28 or
                                    row(4 downto 0) = 29

                                    )
                                )
                                or
                                (
                                    (
                                        column(4 downto 0) = 12 or
                                        column(4 downto 0) = 19
                                        
        
                                    )
                                     and
                                    ( ---sefkskv
                                    row(4 downto 0) = 6 or
                                    row(4 downto 0) = 7 or
                                    row(4 downto 0) = 8 or
                                    row(4 downto 0) = 9 or
                                    row(4 downto 0) = 10 or
                                    row(4 downto 0) = 11 or --10
                                    row(4 downto 0) = 12 or
                                    row(4 downto 0) = 13 or
                                    row(4 downto 0) = 14 or
                                    row(4 downto 0) = 15 or
                                    row(4 downto 0) = 16 or
                                    row(4 downto 0) = 17 or
                                    row(4 downto 0) = 18 or
                                    row(4 downto 0) = 19 or
                                    row(4 downto 0) = 20 or
                                    
                                    row(4 downto 0) = 25 or
                                    row(4 downto 0) = 26 or
                                    row(4 downto 0) = 27 or
                                    row(4 downto 0) = 28 or
                                    row(4 downto 0) = 29

                                    )
                                )
                                or
                                (
                                    (
                                        column(4 downto 0) = 11 or
                                        column(4 downto 0) = 20
                                        
        
                                    )
                                     and
                                    ( ---sefkskv
                                    row(4 downto 0) = 7 or
                                    row(4 downto 0) = 8 or
                                    row(4 downto 0) = 9 or
                                    row(4 downto 0) = 10 or
                                    row(4 downto 0) = 11 or --10
                                    row(4 downto 0) = 12 or
                                    row(4 downto 0) = 13 or
                                    row(4 downto 0) = 14 or
                                    row(4 downto 0) = 15 or
                                    row(4 downto 0) = 16 or
                                    row(4 downto 0) = 17 or
                                    row(4 downto 0) = 18 or
                                    row(4 downto 0) = 19 or
                                    row(4 downto 0) = 20 or
                                    
                                    row(4 downto 0) = 27 or
                                    row(4 downto 0) = 28 or
                                    row(4 downto 0) = 29

                                    )
                                )
                                or
                                (
                                    (
                                        column(4 downto 0) = 10 or
                                        column(4 downto 0) = 21
                                        
        
                                    )
                                     and
                                    ( ---sefkskv
                                    row(4 downto 0) = 8 or
                                    row(4 downto 0) = 9 or
                                    row(4 downto 0) = 10 or
                                    row(4 downto 0) = 11 or --10
                                    row(4 downto 0) = 12 or
                                    row(4 downto 0) = 13 or
                                    row(4 downto 0) = 14 or
                                    row(4 downto 0) = 15 or
                                    row(4 downto 0) = 16 or
                                    row(4 downto 0) = 17 or
                                    row(4 downto 0) = 18 or
                                    row(4 downto 0) = 19 or
                                    row(4 downto 0) = 20 or
                                    row(4 downto 0) = 21 or
                                    
                                    row(4 downto 0) = 28 or
                                    row(4 downto 0) = 29

                                    )
                                )
                                or
                                (
                                    (
                                        column(4 downto 0) = 9 or
                                        column(4 downto 0) = 22
                                        
        
                                    )
                                     and
                                    ( ---sefkskv
                                    row(4 downto 0) = 9 or
                                    row(4 downto 0) = 10 or
                                    row(4 downto 0) = 11 or --10
                                    row(4 downto 0) = 12 or
                                    row(4 downto 0) = 13 or
                                    row(4 downto 0) = 14 or
                                    row(4 downto 0) = 15 or
                                    row(4 downto 0) = 16 or
                                    row(4 downto 0) = 17 or
                                    row(4 downto 0) = 18 or
                                    row(4 downto 0) = 19 or
                                    row(4 downto 0) = 20 or
                                    row(4 downto 0) = 21 or
                                    
                                    row(4 downto 0) = 29

                                    )
                                )
                                or
                                (
                                    (
                                        column(4 downto 0) = 8 or
                                        column(4 downto 0) = 23
                                        
        
                                    )
                                     and
                                    ( ---sefkskv
                                    row(4 downto 0) = 10 or
                                    row(4 downto 0) = 11 or --10
                                    row(4 downto 0) = 12 or
                                    row(4 downto 0) = 13 or
                                    row(4 downto 0) = 14 or
                                    row(4 downto 0) = 15 or
                                    row(4 downto 0) = 16 or
                                    row(4 downto 0) = 17 or
                                    row(4 downto 0) = 18 or
                                    row(4 downto 0) = 19 or
                                    row(4 downto 0) = 20 or
                                    row(4 downto 0) = 21 or
                                    row(4 downto 0) = 22
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        column(4 downto 0) = 7 or
                                        column(4 downto 0) = 24
                                        
        
                                    )
                                     and
                                    ( ---sefkskv
                                    row(4 downto 0) = 11 or --10
                                    row(4 downto 0) = 12 or
                                    row(4 downto 0) = 13 or
                                    row(4 downto 0) = 14 or
                                    row(4 downto 0) = 15 or
                                    row(4 downto 0) = 16 or
                                    row(4 downto 0) = 17 or
                                    row(4 downto 0) = 18 or
                                    row(4 downto 0) = 19 or
                                    row(4 downto 0) = 20 or
                                    row(4 downto 0) = 21 or
                                    row(4 downto 0) = 22
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        column(4 downto 0) = 6 or
                                        column(4 downto 0) = 25
                                        
        
                                    )
                                     and
                                    ( ---sefkskv
                                    row(4 downto 0) = 12 or
                                    row(4 downto 0) = 13 or
                                    row(4 downto 0) = 14 or
                                    row(4 downto 0) = 15 or
                                    row(4 downto 0) = 16 or
                                    row(4 downto 0) = 17 or
                                    row(4 downto 0) = 18 or
                                    row(4 downto 0) = 19 or
                                    row(4 downto 0) = 20 or
                                    row(4 downto 0) = 21 or
                                    row(4 downto 0) = 22
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        column(4 downto 0) = 5 or
                                        column(4 downto 0) = 26
                                        
        
                                    )
                                     and
                                    ( ---sefkskv
                                    row(4 downto 0) = 14 or
                                    row(4 downto 0) = 15 or
                                    row(4 downto 0) = 16 or
                                    row(4 downto 0) = 17 or
                                    row(4 downto 0) = 18 or
                                    row(4 downto 0) = 19 or
                                    row(4 downto 0) = 20 or
                                    row(4 downto 0) = 21 or
                                    row(4 downto 0) = 22
                                    

                                    )
                                )
                                or
                                (
                                    (
                                        column(4 downto 0) = 4 or
                                        column(4 downto 0) = 27
                                        
        
                                    )
                                     and
                                    ( ---sefkskv
                                    row(4 downto 0) = 17 or
                                    row(4 downto 0) = 18 or
                                    row(4 downto 0) = 19 or
                                    row(4 downto 0) = 20 or
                                    row(4 downto 0) = 21
                                    

                                    )
                                )
                                or
                                ------START BORDER-------------------------
                                (
                                (
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 31 ---sdgfichazldvjs
                                
                                
                                )
                                and
                                ( ---sefkskv
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 1 or
                                row(4 downto 0) = 2 or
                                row(4 downto 0) = 3 or
                                row(4 downto 0) = 4 or
                                row(4 downto 0) = 5 or
                                row(4 downto 0) = 6 or
                                row(4 downto 0) = 7 or
                                row(4 downto 0) = 8 or
                                row(4 downto 0) = 9 or
                                row(4 downto 0) = 10 or
                                row(4 downto 0) = 11 or --10
                                row(4 downto 0) = 12 or
                                row(4 downto 0) = 13 or
                                row(4 downto 0) = 14 or
                                row(4 downto 0) = 15 or
                                row(4 downto 0) = 16 or
                                row(4 downto 0) = 17 or
                                row(4 downto 0) = 18 or
                                row(4 downto 0) = 19 or
                                row(4 downto 0) = 20 or
                                row(4 downto 0) = 21 or
                                row(4 downto 0) = 22 or
                                row(4 downto 0) = 23 or
                                row(4 downto 0) = 24 or
                                row(4 downto 0) = 25 or
                                row(4 downto 0) = 26 or
                                row(4 downto 0) = 27 or
                                row(4 downto 0) = 28 or
                                row(4 downto 0) = 29 or
                                row(4 downto 0) = 30 or
                                row(4 downto 0) = 31
                                
                                )
                                )
                                or
                                (
                                (
                                row(4 downto 0) = 0 or
                                row(4 downto 0) = 31 ---sdgfichazldvjs
                                
                                
                                )
                                and
                                ( ---sefkskv
                                column(4 downto 0) = 0 or
                                column(4 downto 0) = 1 or
                                column(4 downto 0) = 2 or
                                column(4 downto 0) = 3 or
                                column(4 downto 0) = 4 or
                                column(4 downto 0) = 5 or
                                column(4 downto 0) = 6 or
                                column(4 downto 0) = 7 or
                                column(4 downto 0) = 8 or
                                column(4 downto 0) = 9 or
                                column(4 downto 0) = 10 or
                                column(4 downto 0) = 11 or --10
                                column(4 downto 0) = 12 or
                                column(4 downto 0) = 13 or
                                column(4 downto 0) = 14 or
                                column(4 downto 0) = 15 or
                                column(4 downto 0) = 16 or
                                column(4 downto 0) = 17 or
                                column(4 downto 0) = 18 or
                                column(4 downto 0) = 19 or
                                column(4 downto 0) = 20 or
                                column(4 downto 0) = 21 or
                                column(4 downto 0) = 22 or
                                column(4 downto 0) = 23 or
                                column(4 downto 0) = 24 or
                                column(4 downto 0) = 25 or
                                column(4 downto 0) = 26 or
                                column(4 downto 0) = 27 or
                                column(4 downto 0) = 28 or
                                column(4 downto 0) = 29 or
                                column(4 downto 0) = 30 or
                                column(4 downto 0) = 31
                                
                                )
                                )
                                -----------END BORDER-------------------------
                                                                    
                                    
                            )
                    else '0';



clubs <= '1' when (ch1(4 downto 0) = "00011") and 
                                ((
    (
        column(4 downto 0) = 15 or
        column(4 downto 0) = 16
        

    )
     and
    (
    row(4 downto 0) = 2 or
    row(4 downto 0) = 3 or
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17 or
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21 or
    row(4 downto 0) = 22 or -- 10
    row(4 downto 0) = 23 or
    row(4 downto 0) = 24 or
    row(4 downto 0) = 25 or
    row(4 downto 0) = 26 or
    row(4 downto 0) = 27 or
    row(4 downto 0) = 28 or
    row(4 downto 0) = 29

    )
)
or
(
    ( --s-fdgvfsdv
    row(4 downto 0) = 2 or
    row(4 downto 0) = 3 or
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17
        

    )
     and
    (
        column(4 downto 0) = 14 or
        column(4 downto 0) = 17

    )
)
or
(
    (
        column(4 downto 0) = 13 or
        column(4 downto 0) = 18
        

    )
     and
    ( ---sefkskv

    row(4 downto 0) = 2 or
    row(4 downto 0) = 3 or
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or

    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17 or
    row(4 downto 0) = 18

    )
)
or
(
    (
        column(4 downto 0) = 12 or
        column(4 downto 0) = 19
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 2 or
    row(4 downto 0) = 3 or
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17 or
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 

    )
)
or
(
    (
        column(4 downto 0) = 11 or
        column(4 downto 0) = 20
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 3 or
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17 or
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20
    )
)
or
(
    (
        column(4 downto 0) = 10 or
        column(4 downto 0) = 21
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    
    
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17 or
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21

    )
)
or
(
    (
        column(4 downto 0) = 9 or
        column(4 downto 0) = 22
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    
    
    
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17 or
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21 or
    row(4 downto 0) = 22

    )
)
or
(
    (
        column(4 downto 0) = 5 or
        column(4 downto 0) = 6 or
        column(4 downto 0) = 7 or
        column(4 downto 0) = 8 or
        column(4 downto 0) = 23 or
        column(4 downto 0) = 24 or
        column(4 downto 0) = 25 or
        column(4 downto 0) = 26
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17 or
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21 or
    row(4 downto 0) = 22
    

    )
)
or
(
    (
        column(4 downto 0) = 4 or
        column(4 downto 0) = 27       

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17 or
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20
    

    )
)
or
(
    (
        column(4 downto 0) = 3 or
        column(4 downto 0) = 28
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17 or
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19
    

    )
)
or
------START BORDER-------------------------
(
(
column(4 downto 0) = 0 or
column(4 downto 0) = 31 ---sdgfichazldvjs


)
and
( ---sefkskv
row(4 downto 0) = 0 or
row(4 downto 0) = 1 or
row(4 downto 0) = 2 or
row(4 downto 0) = 3 or
row(4 downto 0) = 4 or
row(4 downto 0) = 5 or
row(4 downto 0) = 6 or
row(4 downto 0) = 7 or
row(4 downto 0) = 8 or
row(4 downto 0) = 9 or
row(4 downto 0) = 10 or
row(4 downto 0) = 11 or --10
row(4 downto 0) = 12 or
row(4 downto 0) = 13 or
row(4 downto 0) = 14 or
row(4 downto 0) = 15 or
row(4 downto 0) = 16 or
row(4 downto 0) = 17 or
row(4 downto 0) = 18 or
row(4 downto 0) = 19 or
row(4 downto 0) = 20 or
row(4 downto 0) = 21 or
row(4 downto 0) = 22 or
row(4 downto 0) = 23 or
row(4 downto 0) = 24 or
row(4 downto 0) = 25 or
row(4 downto 0) = 26 or
row(4 downto 0) = 27 or
row(4 downto 0) = 28 or
row(4 downto 0) = 29 or
row(4 downto 0) = 30 or
row(4 downto 0) = 31

)
)
or
(
(
row(4 downto 0) = 0 or
row(4 downto 0) = 31 ---sdgfichazldvjs


)
and
( ---sefkskv
column(4 downto 0) = 0 or
column(4 downto 0) = 1 or
column(4 downto 0) = 2 or
column(4 downto 0) = 3 or
column(4 downto 0) = 4 or
column(4 downto 0) = 5 or
column(4 downto 0) = 6 or
column(4 downto 0) = 7 or
column(4 downto 0) = 8 or
column(4 downto 0) = 9 or
column(4 downto 0) = 10 or
column(4 downto 0) = 11 or --10
column(4 downto 0) = 12 or
column(4 downto 0) = 13 or
column(4 downto 0) = 14 or
column(4 downto 0) = 15 or
column(4 downto 0) = 16 or
column(4 downto 0) = 17 or
column(4 downto 0) = 18 or
column(4 downto 0) = 19 or
column(4 downto 0) = 20 or
column(4 downto 0) = 21 or
column(4 downto 0) = 22 or
column(4 downto 0) = 23 or
column(4 downto 0) = 24 or
column(4 downto 0) = 25 or
column(4 downto 0) = 26 or
column(4 downto 0) = 27 or
column(4 downto 0) = 28 or
column(4 downto 0) = 29 or
column(4 downto 0) = 30 or
column(4 downto 0) = 31

)
)
-----------END BORDER-------------------------
                                    
    
)
else '0';

-- make object2 the boundary of the box
diamond <= '1' when (ch1(4 downto 0) = "00010") and 
                                ((
(
column(4 downto 0) = 15


)
and
(
row(4 downto 0) = 3 or
row(4 downto 0) = 4 or
row(4 downto 0) = 5 or
row(4 downto 0) = 6 or
row(4 downto 0) = 7 or
row(4 downto 0) = 8 or
row(4 downto 0) = 9 or
row(4 downto 0) = 10 or
row(4 downto 0) = 11 or --10
row(4 downto 0) = 12 or
row(4 downto 0) = 13 or
row(4 downto 0) = 14 or
row(4 downto 0) = 15 or
row(4 downto 0) = 16 or
row(4 downto 0) = 17  or 
row(4 downto 0) = 18 or
row(4 downto 0) = 19 or
row(4 downto 0) = 20 or
row(4 downto 0) = 21 or
row(4 downto 0) = 22 or
row(4 downto 0) = 23 or
row(4 downto 0) = 24 or
row(4 downto 0) = 25 or
row(4 downto 0) = 26 or
row(4 downto 0) = 27

)
)
or
(
( --s-fdgvfsdv
row(4 downto 0) = 4 or
row(4 downto 0) = 5 or
row(4 downto 0) = 6 or
row(4 downto 0) = 7 or
row(4 downto 0) = 8 or
row(4 downto 0) = 9 or
row(4 downto 0) = 10 or
row(4 downto 0) = 11 or --10
row(4 downto 0) = 12 or
row(4 downto 0) = 13 or
row(4 downto 0) = 14 or
row(4 downto 0) = 15 or
row(4 downto 0) = 16 or
row(4 downto 0) = 17  or 
row(4 downto 0) = 18 or
row(4 downto 0) = 19 or
row(4 downto 0) = 20 or
row(4 downto 0) = 21 or
row(4 downto 0) = 22 or
row(4 downto 0) = 23 or
row(4 downto 0) = 24 or
row(4 downto 0) = 25 


)
and
(
column(4 downto 0) = 14 or
column(4 downto 0) = 16

)
)
or
(
(
column(4 downto 0) = 13 or
column(4 downto 0) = 17


)
and
( ---sefkskv
row(4 downto 0) = 6 or
row(4 downto 0) = 7 or
row(4 downto 0) = 8 or
row(4 downto 0) = 9 or
row(4 downto 0) = 10 or
row(4 downto 0) = 11 or --10
row(4 downto 0) = 12 or
row(4 downto 0) = 13 or
row(4 downto 0) = 14 or
row(4 downto 0) = 15 or
row(4 downto 0) = 16 or
row(4 downto 0) = 17  or 
row(4 downto 0) = 18 or
row(4 downto 0) = 19 or
row(4 downto 0) = 20 or
row(4 downto 0) = 21 or
row(4 downto 0) = 22 or
row(4 downto 0) = 23 


)
)
or
(
(
column(4 downto 0) = 12 or
column(4 downto 0) = 18


)
and
( ---sefkskv
row(4 downto 0) = 8 or
row(4 downto 0) = 9 or
row(4 downto 0) = 10 or
row(4 downto 0) = 11 or --10
row(4 downto 0) = 12 or
row(4 downto 0) = 13 or
row(4 downto 0) = 14 or
row(4 downto 0) = 15 or
row(4 downto 0) = 16 or
row(4 downto 0) = 17  or 
row(4 downto 0) = 18 or
row(4 downto 0) = 19 or
row(4 downto 0) = 20 or
row(4 downto 0) = 21 


)
)
or
(
(
column(4 downto 0) = 11 or
column(4 downto 0) = 19


)
and
( ---sefkskv
row(4 downto 0) = 10 or
row(4 downto 0) = 11 or --10
row(4 downto 0) = 12 or
row(4 downto 0) = 13 or
row(4 downto 0) = 14 or
row(4 downto 0) = 15 or
row(4 downto 0) = 16 or
row(4 downto 0) = 17  or 
row(4 downto 0) = 18 or
row(4 downto 0) = 19 


)
)
or
(
(
column(4 downto 0) = 10 or
column(4 downto 0) = 20

)
and
( ---sefkskv
row(4 downto 0) = 12 or
row(4 downto 0) = 13 or
row(4 downto 0) = 14 or
row(4 downto 0) = 15 or
row(4 downto 0) = 16 or
row(4 downto 0) = 17 


)
)
or
(
(
column(4 downto 0) = 9 or
column(4 downto 0) = 21


)
and
( ---sefkskv
row(4 downto 0) = 14 or
row(4 downto 0) = 15


)
)
or
------START BORDER-------------------------
(
(
column(4 downto 0) = 0 or
column(4 downto 0) = 31 ---sdgfichazldvjs


)
and
( ---sefkskv
row(4 downto 0) = 0 or
row(4 downto 0) = 1 or
row(4 downto 0) = 2 or
row(4 downto 0) = 3 or
row(4 downto 0) = 4 or
row(4 downto 0) = 5 or
row(4 downto 0) = 6 or
row(4 downto 0) = 7 or
row(4 downto 0) = 8 or
row(4 downto 0) = 9 or
row(4 downto 0) = 10 or
row(4 downto 0) = 11 or --10
row(4 downto 0) = 12 or
row(4 downto 0) = 13 or
row(4 downto 0) = 14 or
row(4 downto 0) = 15 or
row(4 downto 0) = 16 or
row(4 downto 0) = 17 or
row(4 downto 0) = 18 or
row(4 downto 0) = 19 or
row(4 downto 0) = 20 or
row(4 downto 0) = 21 or
row(4 downto 0) = 22 or
row(4 downto 0) = 23 or
row(4 downto 0) = 24 or
row(4 downto 0) = 25 or
row(4 downto 0) = 26 or
row(4 downto 0) = 27 or
row(4 downto 0) = 28 or
row(4 downto 0) = 29 or
row(4 downto 0) = 30 or
row(4 downto 0) = 31

)
)
or
(
(
row(4 downto 0) = 0 or
row(4 downto 0) = 31 ---sdgfichazldvjs


)
and
( ---sefkskv
column(4 downto 0) = 0 or
column(4 downto 0) = 1 or
column(4 downto 0) = 2 or
column(4 downto 0) = 3 or
column(4 downto 0) = 4 or
column(4 downto 0) = 5 or
column(4 downto 0) = 6 or
column(4 downto 0) = 7 or
column(4 downto 0) = 8 or
column(4 downto 0) = 9 or
column(4 downto 0) = 10 or
column(4 downto 0) = 11 or --10
column(4 downto 0) = 12 or
column(4 downto 0) = 13 or
column(4 downto 0) = 14 or
column(4 downto 0) = 15 or
column(4 downto 0) = 16 or
column(4 downto 0) = 17 or
column(4 downto 0) = 18 or
column(4 downto 0) = 19 or
column(4 downto 0) = 20 or
column(4 downto 0) = 21 or
column(4 downto 0) = 22 or
column(4 downto 0) = 23 or
column(4 downto 0) = 24 or
column(4 downto 0) = 25 or
column(4 downto 0) = 26 or
column(4 downto 0) = 27 or
column(4 downto 0) = 28 or
column(4 downto 0) = 29 or
column(4 downto 0) = 30 or
column(4 downto 0) = 31

)
)
-----------END BORDER--------------------------
    

)
else '0';
            
heart <= '1' when (ch1(4 downto 0) = "00001") and 
                                ((
    (
        column(4 downto 0) = 3 or
        column(4 downto 0) = 27
        

    )
     and
    (
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12

    )
)
or
(
    ( --s-fdgvfsdv
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15
        

    )
     and
    (
        column(4 downto 0) = 4 or
        column(4 downto 0) = 26

    )
)
or
(
    (
        column(4 downto 0) = 5 or
        column(4 downto 0) = 25
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17 


    )
)
or
(
    (
        column(4 downto 0) =6 or
        column(4 downto 0) = 24
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17  or 
    row(4 downto 0) = 18


    )
)
or
(
    (
        column(4 downto 0) =7 or
        column(4 downto 0) = 23
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17  or 
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19


    )
)
or
(
    (
        column(4 downto 0) =8 or
        column(4 downto 0) = 22
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17  or 
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20


    )
)
or
(
    (
        column(4 downto 0) = 9 or
        column(4 downto 0) = 21
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17  or 
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21


    )
)
or
(
    (
        column(4 downto 0) = 10 or
        column(4 downto 0) = 20
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17  or 
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21 or
    row(4 downto 0) = 22


    )
)
or
(
    (
        column(4 downto 0) = 11 or
        column(4 downto 0) = 19
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17  or 
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21 or
    row(4 downto 0) = 22 or
    row(4 downto 0) = 23


    )
)
or
(
    (
        column(4 downto 0) = 12 or
        column(4 downto 0) = 18
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17  or 
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21 or
    row(4 downto 0) = 22 or
    row(4 downto 0) = 23 or
    row(4 downto 0) = 24


    )
)
or
(
    (
        column(4 downto 0) = 13 or
        column(4 downto 0) = 17
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17  or 
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21 or
    row(4 downto 0) = 22 or
    row(4 downto 0) = 23 or
    row(4 downto 0) = 24 or
    row(4 downto 0) = 25


    )
)
or
(
    (
        column(4 downto 0) = 14 or
        column(4 downto 0) = 16
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17  or 
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21 or
    row(4 downto 0) = 22 or
    row(4 downto 0) = 23 or
    row(4 downto 0) = 24 or
    row(4 downto 0) = 25 or
    row(4 downto 0) = 26


    )
)
or
(
    (
        column(4 downto 0) = 15
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17  or 
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21 or
    row(4 downto 0) = 22 or
    row(4 downto 0) = 23 or
    row(4 downto 0) = 24 or
    row(4 downto 0) = 25 or
    row(4 downto 0) = 26 or
    row(4 downto 0) = 27

    )
)
or
------START BORDER-------------------------
(
    (
        column(4 downto 0) = 0 or
        column(4 downto 0) = 31 ---sdgfichazldvjs
        

    )
     and
    ( ---sefkskv
    row(4 downto 0) = 0 or
    row(4 downto 0) = 1 or
    row(4 downto 0) = 2 or
    row(4 downto 0) = 3 or
    row(4 downto 0) = 4 or
    row(4 downto 0) = 5 or
    row(4 downto 0) = 6 or
    row(4 downto 0) = 7 or
    row(4 downto 0) = 8 or
    row(4 downto 0) = 9 or
    row(4 downto 0) = 10 or
    row(4 downto 0) = 11 or --10
    row(4 downto 0) = 12 or
    row(4 downto 0) = 13 or
    row(4 downto 0) = 14 or
    row(4 downto 0) = 15 or
    row(4 downto 0) = 16 or
    row(4 downto 0) = 17 or
    row(4 downto 0) = 18 or
    row(4 downto 0) = 19 or
    row(4 downto 0) = 20 or
    row(4 downto 0) = 21 or
    row(4 downto 0) = 22 or
    row(4 downto 0) = 23 or
    row(4 downto 0) = 24 or
    row(4 downto 0) = 25 or
    row(4 downto 0) = 26 or
    row(4 downto 0) = 27 or
    row(4 downto 0) = 28 or
    row(4 downto 0) = 29 or
    row(4 downto 0) = 30 or
    row(4 downto 0) = 31

    )
)
or
(
    (
        row(4 downto 0) = 0 or
        row(4 downto 0) = 31 ---sdgfichazldvjs
        

    )
     and
    ( ---sefkskv
    column(4 downto 0) = 0 or
    column(4 downto 0) = 1 or
    column(4 downto 0) = 2 or
    column(4 downto 0) = 3 or
    column(4 downto 0) = 4 or
    column(4 downto 0) = 5 or
    column(4 downto 0) = 6 or
    column(4 downto 0) = 7 or
    column(4 downto 0) = 8 or
    column(4 downto 0) = 9 or
    column(4 downto 0) = 10 or
    column(4 downto 0) = 11 or --10
    column(4 downto 0) = 12 or
    column(4 downto 0) = 13 or
    column(4 downto 0) = 14 or
    column(4 downto 0) = 15 or
    column(4 downto 0) = 16 or
    column(4 downto 0) = 17 or
    column(4 downto 0) = 18 or
    column(4 downto 0) = 19 or
    column(4 downto 0) = 20 or
    column(4 downto 0) = 21 or
    column(4 downto 0) = 22 or
    column(4 downto 0) = 23 or
    column(4 downto 0) = 24 or
    column(4 downto 0) = 25 or
    column(4 downto 0) = 26 or
    column(4 downto 0) = 27 or
    column(4 downto 0) = 28 or
    column(4 downto 0) = 29 or
    column(4 downto 0) = 30 or
    column(4 downto 0) = 31

    )
)
-----------END BORDER--------------------------
                                    
    
)
else '0';

                         
end Behavioral;

