----------------------------------------------------------------------------------
-- Name:	George York
-- Date:	Spring 2020
-- File:    graphics_fsm.vhd
-- HW:	    State Machine to test the graphics memory
--          GRID MEMORY example: 2 bits per grid cell (really has 16 bits), for a 64 x 32 grid of 8x8 pixel cells, using 2 BRAMS
-- Pupr:	need to update!!!!.  
--
-- Doc:	Adapted from Dr Coulston's Lab exercise
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity graphics_fsm is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
		   exCol: out std_logic_vector(4 downto 0);
           exRow: out std_logic_vector(3 downto 0);
           exWen : out std_logic;
           exData: out std_logic_vector(15 downto 0));
end graphics_fsm;

architecture Behavioral of graphics_fsm is

	type state_type is (SWAP, DELAY, CHANGE_DATA, SET, CLEAR, INCCOL, LASTCOL, INCROW, LASTROW );
	signal state: state_type;
	
	signal writeCntr: unsigned(17 downto 0);
	
	signal col : unsigned(4 downto 0);
    signal row : unsigned(3 downto 0);
    signal Wen: std_logic;
    
	signal Data, Old_Data: std_logic_vector(15 downto 0);


begin

    exCol <= std_logic_vector(col);
    exRow <= std_logic_vector(row);
    exData <= Data;
    exWen <= Wen;
	-------------------------------------------------------------------------------
	-- Long delay counter
	-------------------------------------------------------------------------------	
	writeCounter: process(clk)
	begin
		if (rising_edge(clk)) then
			if (reset_n = '0') then
				writeCntr <= "000000000000000000";  -- change for graphics memory test
             else
			    writeCntr <= writeCntr+1;
			end if;
		end if;
	end process;
	
	state_proces: process(clk)  
    begin
        if (rising_edge(clk)) then
            if (reset_n = '0') then 
                state <= SWAP;
                row <= "0000";
                col <= "00000";                             
                Data <= "0000000000000001";
                Wen <= '0';
            else 
                case state is
                    when SWAP =>
                        state <= DELAY;            
                    when DELAY => 
                        if (writeCntr = "111111111111111111") then
                            state <= CHANGE_DATA;
                        end if;
                    when CHANGE_DATA => 
                            -- Alternate Objects 
                            
                            if (Old_Data = "0000000000000001") then Data <= "0000000000000010";
                        elsif (Old_Data = "0000000000000010") then Data <= "0000000000000011";
                        elsif (Old_Data = "0000000000000011") then Data <= "0000000000000100";
                        elsif (Old_Data = "0000000000000100") then Data <= "0000000000000101";
                        elsif (Old_Data = "0000000000000101") then Data <= "0000000000000110";
                        elsif (Old_Data = "0000000000000110") then Data <= "0000000000000111";
                        elsif (Old_Data = "0000000000000111") then Data <= "0000000000001000";
                        elsif (Old_Data = "0000000000001000") then Data <= "0000000000001001";
                        elsif (Old_Data = "0000000000001001") then Data <= "0000000000001010";
                        elsif (Old_Data = "0000000000001010") then Data <= "0000000000001011";
                        elsif (Old_Data = "0000000000001011") then Data <= "0000000000001100";
                        elsif (Old_Data = "0000000000001100") then Data <= "0000000000001101";
                        elsif (Old_Data = "0000000000001101") then Data <= "0000000000001110";
                        elsif (Old_Data = "0000000000001110") then Data <= "0000000000001111";
                        elsif (Old_Data = "0000000000001111") then Data <= "0000000000010000";
                        elsif (Old_Data = "0000000000010000") then Data <= "0000000000010001";
                        elsif (Old_Data = "0000000000010001") then Data <= "0000000000010010";
                        elsif (Old_Data = "0000000000010010") then Data <= "0000000000010011";
                        elsif (Old_Data = "0000000000010011") then Data <= "0000000000010100";
                        elsif (Old_Data = "0000000000010100") then Data <= "0000000000010101";
                        elsif (Old_Data = "0000000000010101") then Data <= "0000000000010110";
                        elsif (Old_Data = "0000000000010110") then Data <= "0000000000010111";
                        elsif (Old_Data = "0000000000010111") then Data <= "0000000000011000";
                        elsif (Old_Data = "0000000000011000") then Data <= "0000000000011001";
                        elsif (Old_Data = "0000000000011001") then Data <= "0000000000011010";
                        elsif (Old_Data = "0000000000011010") then Data <= "0000000000011011";
                        elsif (Old_Data = "0000000000011011") then Data <= "0000000000011100";
                        elsif (Old_Data = "0000000000011100") then Data <= "0000000000000001";

                        end if;
                        state <= SET;
                    when SET =>
                        Wen <= '1';
                        state <= CLEAR;
                        
                    when CLEAR =>
                        Wen <= '0';
                        state <= INCCOL;
                        
                    when INCCOL =>
                        col <= col + 1;
                        state <= LASTCOL;
                                            
                    when LASTCOL =>  -- 64, roll over to zero 
                        if (col = "10100") then
                            col <= "00000";
                            state <= INCROW;
                        else
                            state <= DELAY;
                        end if; 
                        
                    when INCROW =>
                        row <= row + 1;
                        state <= LASTROW;
                                                
                   when LASTROW => -- 32, roll over to zero
                        if (row = "1111") then
                            row <= "0000";
                            state <= SWAP;
                        else
                            state <= DELAY;
                        end if;
                        
                end case;
            end if;
        end if;
    end process;


    Old_Data <= Data;


end Behavioral;

