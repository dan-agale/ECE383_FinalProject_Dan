----------------------------------------------------------------------------------
-- Name:	Dananga Agalakotuwa
-- Date:	April 13, 2024
-- File:    lab2_datapath.vhdl
-- HW:	    Lab 4
-- Pupr:	This is the lab 2 datapath. This handles printing either the simulation
--          from Lab 2 or the data from Lab 5.
--
-- Documentation:   - C2C Jun Park helped me understand how to convert from unsigned
--                    to signed for the signal coming out of the BRAM. He also pointed
--                    out how amplifying and the chirping should work.
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
library UNIMACRO;
use UNIMACRO.vcomponents.all;
library UNISIM;
use UNISIM.VComponents.all;

entity lab2_datapath is
    Port (
        clk             : in  STD_LOGIC;
        reset_n         : in  STD_LOGIC;
        ch1_sw          : in STD_LOGIC;
        ch2_sw          : in STD_LOGIC;
        exSel           : in STD_LOGIC;
        ac_adc_sdata    : in STD_LOGIC;
        exLbus, exRbus  : in STD_LOGIC_VECTOR(17 downto 0);
        cw              : in STD_LOGIC_VECTOR (2 downto 0);
        btn             : in STD_LOGIC_VECTOR(4 downto 0);
        ac_mclk         : out STD_LOGIC;
        ac_dac_sdata    : out STD_LOGIC;
        ac_bclk         : out STD_LOGIC;
        ac_lrclk        : out STD_LOGIC;
        readyy          : out STD_LOGIC;
        sw              : out STD_LOGIC_VECTOR(2 downto 0);
        scl             : inout STD_LOGIC;
        sda             : inout STD_LOGIC
    );
end lab2_datapath;

architecture Behavioral of lab2_datapath is
    
    component Audio_Codec_Wrapper is
        Port (  clk : in STD_LOGIC;
                reset_n : in STD_LOGIC;
                ac_mclk : out STD_LOGIC;
                ac_adc_sdata : in STD_LOGIC;
                ac_dac_sdata : out STD_LOGIC;
                ac_bclk : out STD_LOGIC;
                ac_lrclk : out STD_LOGIC;
                ready : out STD_LOGIC;
                L_bus_in : in std_logic_vector(17 downto 0); -- left channel input to DAC
                R_bus_in : in std_logic_vector(17 downto 0); -- right channel input to DAC
                L_bus_out : out  std_logic_vector(17 downto 0); -- left channel output from ADC
                R_bus_out : out  std_logic_vector(17 downto 0); -- right channel output from ADC
                scl : inout STD_LOGIC;
                sda : inout STD_LOGIC;
                sim_live : in STD_LOGIC);   --  '0' simulate audio; '1' live audio
    end component;

    signal sim_live                                         :   std_logic;
    signal ready                                            :   std_logic;
	signal L_bus_in, R_bus_in, L_bus_out, R_bus_out         :   std_logic_vector(17 downto 0);	    
    signal writeCntr              :   unsigned (9 downto 0);
    signal ch1, ch2, reset                                  :   std_logic;
    signal readL, readR, D_in_sig_R, D_in_sig_L             :   std_logic_vector(15 downto 0);
    signal ch1_en_sig, ch2_en_sig, comp_G, comp_L, wr_ENB   :   std_logic;
    signal current_Lbus, previous_Lbus                      :   unsigned(9 downto 0);
    signal WRADDR_sig                                       :   std_logic_vector(9 downto 0);
    signal Lbus_16, Rbus_16                                 :   unsigned(15 downto 0);
    signal L_bus_int, R_bus_int                             :   std_logic_vector(17 downto 0);
    	
    type state_type is (WaitEnter,
                        Countup,
                        Up,
                        Down,
                        Left,
                        Right); -- 6 states for debouncing button
    signal state                                            :   state_type;     -- signal for tracking state
    signal timer                                            :   integer := 0;   -- counter signal
    
    
begin


-- convert Signed sample from Codec into a proper Unsigned value for BRAM
	Lbus_16 <= unsigned(L_bus_in(17 downto 2) xor "1000000000000000");
    Rbus_16 <= unsigned(R_bus_in(17 downto 2) xor "1000000000000000");
	
-- status word bits
    sw(0) <= comp_G and comp_L; -- wait_trigger state
	sw(1) <= ready; -- wait_ready state
    sw(2) <= '1' when (writeCntr = "1111111111") else '0'; -- comp state
	readyy <= ready; -- ready signal

-- MUXES
    wr_ENB <= cw(2); -- write enable based on FSM
    WRADDR_sig <= std_logic_vector(writeCntr); -- Write Counter for BRAM
    D_in_sig_L <= std_logic_vector(Lbus_16); -- DI for left BRAM
    D_in_sig_R <= std_logic_vector(Rbus_16); -- DI for right BRAM
    
-- MUX for either Lab2 or Lab 4
    L_bus_int <= exLBus when exSel = '1' else L_bus_out;
    R_bus_int <= exRBus when exSel = '1' else R_bus_out;

-- other CSA statements
    sim_live <= '0';

	

	------------------------------------------------------------------------------
	-- Write Counter (20 to 1023)
	-------------------------------------------------------------------------------
	-- Address counter for RAM
	--		00		hold
	--		01		up
	--		10		down
	--		11		reset
	-------------------------------------------------------------------------------	
	writeCounter: process(clk)
	begin
		if (rising_edge(clk)) then
			if (reset_n = '0') then
				writeCntr <= "0000010100";
			else 
				case cw(1 downto 0) is
					when "00" =>
					   writeCntr <= writeCntr;
					when "01" =>
					   writeCntr <= writeCntr + 1;					
					when "10" =>
					   writeCntr <= writeCntr - 1;					
					when others => 
					   writeCntr <= "0000010100";
				end case;
			end if;
		end if;
	end process;

	-------------------------------------------------------------------------------
	--  Buffer a copy of the sample memory to look for positive trigger crossing
	--  "Loop back" digitized audio input to the output to confirm interface is working
	-------------------------------------------------------------------------------
    process (clk)
        begin
            if (rising_edge(clk)) then
                if reset_n = '0' then
                    L_bus_in <= (others => '0');
                    R_bus_in <= (others => '0');
                elsif(ready = '1') then
                    L_bus_in <= L_bus_int;
                    R_bus_in <= R_bus_int;
                end if;
            end if;
    end process;

	-------------------------------------------------------------------------------
	-- Triggering Logic: A positive crossing of the trigger occurs when the previous
	-- value is less than the trigger and the current value is greater than or equal
	-- to the trigger.  Set the status word to alert the FSM that it should start 
	-- recording the samples.
	-------------------------------------------------------------------------------	
		
	current_Lbus <= Lbus_16(15 downto 6); -- get 10 MSB for comparisons

	------------------------------------------------------------------------------
	-- Buffer register to keep track of previous Lbus value
	------------------------------------------------------------------------------ 
    process (clk)
        begin
            if (rising_edge(clk)) then
                if reset_n = '0' then
                    previous_Lbus <= (others => '0');
                elsif(ready = '1') then
                    previous_Lbus <= current_Lbus;
                end if;
            end if;
    end process;    
    


	-------------------------------------------------------------------------------
	-- Instantiate the Audio Codec Wrapper
	-------------------------------------------------------------------------------
    Audio_Codec : Audio_Codec_Wrapper
        port map (
            clk => clk,
            reset_n => reset_n, 
            ac_mclk => ac_mclk,
            ac_adc_sdata => ac_adc_sdata,
            ac_dac_sdata => ac_dac_sdata,
            ac_bclk => ac_bclk,
            ac_lrclk => ac_lrclk,
            ready => ready,
            L_bus_in => L_bus_in, -- left channel input to DAC
            R_bus_in => R_bus_in, -- right channel input to DAC
            L_bus_out => L_bus_out, -- left channel output from ADC
            R_bus_out => R_bus_out, -- right channel output from ADC
            scl => scl,
            sda => sda,
            sim_live => sim_live);  --  '0' simulate audio; '1' live audio

end Behavioral;

