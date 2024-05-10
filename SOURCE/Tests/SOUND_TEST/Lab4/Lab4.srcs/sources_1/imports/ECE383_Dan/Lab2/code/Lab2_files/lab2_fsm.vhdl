----------------------------------------------------------------------------------
-- Name:	Dananga Agalakotuwa
-- Date:	April 13, 2024
-- File:    lab2_fsm.vhdl
-- HW:	    Lab 4
-- Pupr:	Lab 2 Finite State Machine for the write circuitry.  
--
-- Documentation:	None.
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


entity lab2_fsm is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           sw : in  STD_LOGIC_VECTOR (2 downto 0);
           cw : out  STD_LOGIC_VECTOR (2 downto 0));
end lab2_fsm;

architecture Behavioral of lab2_fsm is

	type state_type is (init,
	                    wait_trigger,
	                    wait_ready,
	                    write,
	                    inc,
	                    comp);
	                    
	signal state: state_type;

begin

	-----------------------------------------------------------------
    --                          SW table
	-----------------------------------------------------------------
    --        bit 2             bit 1               bit 0                                
    --        wait_trigger      wait_ready          Counter Compare                       
    -----------------------------------------------------------------

	---------------------------------------------------------
    --                      State Machine
	---------------------------------------------------------
	--|  STATE          |   cw0     |   cw1     |   cw2     |
	---------------------------------------------------------
    --|  init           |    0      |    1      |    1      | 
    --|  wait_trigger   |    0      |    0      |    0      |
    --|  wait_ready     |    0      |    0      |    0      |
    --|  write          |    1      |    0      |    0      |
    --|  inc            |    0      |    0      |    1      |
    --|  comp           |    0      |    0      |    0      |
    ---------------------------------------------------------   
	state_proces: process(clk)  
	
	begin
    if (rising_edge(clk)) then
	   if (reset_n = '0') then 
				state <= init;
        else 
            case state is
                when init =>
                    state <= wait_trigger;
                    
                when wait_trigger =>
                    if (sw(0) = '1') then
                        state <= wait_ready; end if;
                        
                when wait_ready =>
                    if (sw(1) = '1') then
                        state <= write; end if;
                        
                when write =>
                    state <= inc;
                    
                when inc =>
                    state <= comp;
                    
                when comp =>
                    if (sw(2) = '1') then
                        state <= init;
                    elsif (sw(2) = '0') then
                        state <= wait_ready; end if;
            end case;
        end if;
    end if;
    
	end process;

	---------------------------------------------------
    --              CW output table
	---------------------------------------------------
    --        bit 2             bit 1,0                                
    --        WriteBRAM         Counter            
    --        0 - hold          00 - hold                   
    --        1 - write         01 - count up
    --                          10 - count down
    --                          11 - reset                           
    ---------------------------------------------------
	
    cw <= "011" when state = init else
          "001" when state = inc else
          "100" when state = write else
          "000";

end Behavioral;

