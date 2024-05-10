--------------------------------------------------------------------
-- Name:	Dananga Agalakotuwa
-- Date:	May 2024
-- File:	ir_fsm.vhd
-- HW:	    Final Project
-- Crs:     ECE 383
-- Purp:	Finite State Machine for IR sensor. 
--
-- Academic Integrity Statement: I certify that, while others may have 
-- assisted me in brain storming, debugging and validating this program, 
-- the program itself is my own work. I understand that submitting code 
-- which is the work of other individuals is a violation of the honor   
-- code.  I also understand that if I knowingly give my original work to 
-- another individual is also a violation of the honor code. 
------------------------------------------------------------------------- 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ir_fsm is
	Port(
            clk          : in  STD_LOGIC;
			reset        : in  STD_LOGIC;
			ir_data      : in STD_LOGIC;
			flag         : in std_logic;
			sw           : in STD_LOGIC_VECTOR(1 downto 0);
			cw           : out STD_LOGIC_VECTOR(3 downto 0)
    );		
end ir_fsm;

architecture behavior of ir_fsm is

	type state_type is (
	                    start,
	                    init,
	                    startLow,
	                    startHigh,
	                    nextData,
	                    initCount,
	                    incCount,
	                    holdCount,
	                    getCount,
	                    one,
	                    zero,
	                    DONE
                        );
	                    
    signal state    :   state_type;
    signal bitNumber:   unsigned(7 downto 0);
	
begin
	
    state_process: process(clk)
	 begin
		if (rising_edge(clk)) then
			if (reset = '0') then 
				state <= start;
				
			else
				case state is	
				    when start =>
				        if (flag = '1') then
				            state <= init;
                        end if;
					when init =>
                        if (ir_data = '0') then
                            state <= startLow;
                        end if;
					       
					when startLow =>
                        if (ir_data = '1') then
                            state <= startHigh;
                        end if;
					       
                    when startHigh =>
                        if (ir_data = '0') then
                            state <= nextData;
                        end if;
                   
                    when nextData =>
                        if (ir_data = '1') then
                            state <= initCount;
                        end if;
					   
                    when initCount =>
                        state <= incCount;
                                                
                    when incCount =>
                        if (sw = "11") then
                            state <= DONE;
                        end if;
                        if (ir_data = '0') then
                            state <= holdCount;
                        end if;
					   
                    when holdCount =>
                        state <= getCount;

                    when getCount =>

                        if (sw = "01") then
                            state <= one;
                            
                        elsif (sw = "00") then
                            state <= zero;
                            
                        end if;
                    
                    when one =>
                        state <= nextData;
                    
                    when zero =>
                        state <= nextData;
					   
					when Done =>	
					   state <= start;		
					   					
				end case;
			end if;
		end if;
	end process;

	------------------------------------------------------------------------------
	--			OUTPUT EQUATIONS
	--	
	--         bit 2           bit 1,0					             
	--         decode Bit       Counter		    
	--         0 - zero        00 clear	        	    
	--         1 - one       01 count up				
	--                         11 stop counter		    
	------------------------------------------------------------------------------	
	cw <= "0000" when state = initCount else
	      "0001" when state = incCount else
          "0010" when state = holdCount else
          "1100" when state = one else
          "1000" when state = zero else
          "0010";

	
end behavior;	