----------------------------------------------------------------------------------
-- Name:	Dananga Agalakotuwa
-- Date:	April 13, 2024
-- File:    lab4_fsm.vhd
-- HW:	    Reused from Lab 4 for Final Project
-- Pupr:	Lab 4 Finite State Machine for the write circuitry.  
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


entity lab4_fsm is
    Port ( clk      : in STD_LOGIC;
           reset_n  : in STD_LOGIC;
           ready    : in STD_LOGIC;
           cw       : out STD_LOGIC_VECTOR (3 downto 0);
           winFlag  : in std_logic);
end lab4_fsm;

architecture Behavioral of lab4_fsm is

	type state_type is (bigwait, wait1,
	                    inc,
	                    baseAddr,
	                    saveBase,
	                    nextAddr,
	                    saveNext);
	                    
	signal state: state_type;

begin

    ------------------------------------------------------------------------
    --                              State Machine
    ------------------------------------------------------------------------
    --|     STATE          |   cw3     |   cw2     |   cw1     |   cw0     |
    ------------------------------------------------------------------------
    --|     bigwait        |    1      |    0      |    0      |    0      | 
    --|     wait1          |    0      |    0      |    0      |    0      | 
    --|     inc            |    0      |    0      |    0      |    1      |
    --|     baseAddr       |    0      |    0      |    0      |    0      |
    --|     saveBase       |    0      |    1      |    0      |    0      |
    --|     nextAddr       |    0      |    0      |    1      |    0      |
    --|     saveNext       |    1      |    0      |    0      |    0      |
    ------------------------------------------------------------------------
    
    
	state_proces: process(clk)  
	
	begin
        if (rising_edge(clk)) then
           if (reset_n = '0') then 
                    state <= bigwait;
            else 
                case state is
                    when bigwait =>
                        if (winFlag = '1') then
                            state <= wait1; end if;
                    when wait1 =>
                        if (ready = '1') then
                            state <= inc; end if;
                        
                    when inc =>
                        state <= baseAddr;
                            
                    when baseAddr =>
                        state <= saveBase;
                            
                    when saveBase =>
                        state <= nextAddr;
                        
                    when nextAddr =>
                        state <= saveNext;
                    when saveNext =>
                        state <= bigwait;
    
                end case;
            end if;
        end if;
    
	end process;

	---------------------------------------------------
    --              CW output table
	---------------------------------------------------
    --        cw0 - index offset                    
    --        cw1 - BRAM address
    --        cw2 - base value
    --        cw3 - next value
    ---------------------------------------------------
    
    cw <= "0000" when state = wait1 else
          "0001" when state = inc else
          "0000" when state = baseAddr else
          "0100" when state = saveBase else
          "0010" when state = nextAddr else
          "1000";
          


end Behavioral;