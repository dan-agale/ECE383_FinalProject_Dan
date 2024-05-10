----------------------------------------------------------------------------------
-- Name:	Dananga Agalakotuwa
-- Date:	April 13, 2024
-- File:    slot_machine_fsm.vhd
-- HW:	    Final Project
-- Pupr:	Finite State Machine contolling the win sound(slot machine sound)
-- 	
-- Academic Integrity Statement: I certify that, while others may have 
-- assisted me in brain storming, debugging and validating this program, 
-- the program itself is my own work. I understand that submitting code 
-- which is the work of other individuals is a violation of the honor   
-- code.  I also understand that if I knowingly give my original work to 
-- another individual is also a violation of the honor code. 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity slot_machine_fsm is
    Port ( clk      : in STD_LOGIC;
           reset_n  : in STD_LOGIC;
           sw_slot    : in STD_LOGIC;
           cw_slot       : out STD_LOGIC_VECTOR (4 downto 0));
end slot_machine_fsm;

architecture Behavioral of slot_machine_fsm is

	type state_type is (G6,C7,D7,E7,D77,B6,E77,F7,G7,F77,B7,C,D,E,F,G,A,B,F2,G2,A2);
	                    
	signal state: state_type;
	signal stopFlag: std_logic;
	signal count: unsigned(30 downto 0);

begin

state_proces: process(clk)  
	
	begin
        if (rising_edge(clk)) then
           if (reset_n = '0') then 
                    state <= G6;
            else 
                case state is

                    when G6 =>
                        if (sw_slot = '1') then
                            state <= C7; end if;
                            
                    when C7 =>
                        if (sw_slot = '1') then
                            state <= D7; end if;
                            
                    when D7 =>
                        if (sw_slot = '1') then
                            state <= E7; end if;
                            
                    when E7 => 
                        if (sw_slot = '1') then
                            state <= D77; end if;
                        
                    when D77 =>
                        if (sw_slot = '1') then
                            state <= B6; end if;
                        
                    when B6 =>
                        if (sw_slot = '1') then
                            state <= E77; end if;

                    when E77 =>
                        if (sw_slot = '1') then
                            state <= F7; end if;
                            
                    when F7 =>
                        if (sw_slot = '1') then
                            state <= G7; end if;
                            
                    when G7 =>
                        if (sw_slot = '1') then
                            state <= F77; end if;
                            
                    when F77 =>
                        if (sw_slot = '1') then
                            state <= B7; end if;
                            
                    when B7 =>
                        if (sw_slot = '1') then
                            state <= C; end if;
                            
                    when C =>
                        if (sw_slot = '1') then
                            state <= D; end if;
                            
                    when D =>
                        if (sw_slot = '1') then
                            state <= E; end if;
                            
                    when E =>
                        if (sw_slot = '1') then
                            state <= F; end if;
                            
                    when F =>
                        if (sw_slot = '1') then
                            state <= G; end if;
                        
                    when G =>
                        if (sw_slot = '1') then
                            state <= A; end if;
                        
                    when A =>
                        if (sw_slot = '1') then
                            state <= B; end if;

                    when B =>
                        if (sw_slot = '1') then
                            state <= A2; end if;
                            
                    when A2 =>
                        if (sw_slot = '1') then
                            state <= G2; end if;
                            
                    when G2 =>
                        if (sw_slot = '1') then
                            state <= F2; end if;
                        
                    when F2 =>
                        if (sw_slot = '1') then
                            state <= C; end if;

                end case;
            end if;
        end if;
    
	end process;
    
    -------------------------------------------------
    --              State Machine
    -------------------------------------------------
    --|         STATE           |   cw(4 downto 0)  |
    -------------------------------------------------
    --|         G6              |        00001      | 
    --|         C7              |        00010      |
    --|         D7              |        00011      |
    --|         E7              |        00100      |
    --|         D77             |        00101      |
    --|         B6              |        00110      |
    --|         E77             |        00111      | 
    --|         F7              |        01000      |
    --|         G7              |        01010      |
    --|         F77             |        01011      |
    --|         C               |        01100      |
    -------------------------------------------------

    cw_slot <=    "00001" when state = G6 else
                  "00010" when state = C7 else
                  "00011" when state = D7 else
                  "00100" when state = E7 else
                  "00101" when state = D77 else
                  "00110" when state = B6 else
                  "00111" when state = E77 else
                  "01000" when state = F7 else
                  "01001" when state = G7 else
                  "01010" when state = F77 else
                  "01011" when state = B7 else
                  "01100" when state = C else
                  "01101" when state = D else
                  "01110" when state = E else
                  "01111" when state = F or state = F2 else
                  "10000" when state = G  or state = G2 else
                  "01000" when state = A or state = A2 else
                  "01001" when state = B;

end Behavioral;