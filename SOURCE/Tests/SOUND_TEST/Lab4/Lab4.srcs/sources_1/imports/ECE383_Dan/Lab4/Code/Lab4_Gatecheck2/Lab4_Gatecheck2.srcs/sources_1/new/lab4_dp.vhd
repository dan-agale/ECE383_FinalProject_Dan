----------------------------------------------------------------------------------
-- Name:	Dananga Agalakotuwa
-- Date:	April 13, 2024
-- File:    lab4_dp.vhd
-- HW:	    Lab 4
-- Pupr:	This is the lab 4 datapath. This produces an interpolated and an uninterpolated
--          value (through ch1 & ch2), that will be fed into lab2 datapath.
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

entity lab4_datapath is
    port (
        clk                             : in STD_LOGIC;
        reset_n                         : in STD_LOGIC;
        cw                              : in STD_LOGIC_VECTOR(3 downto 0);
        phase_inc_switch                : in STD_LOGIC_VECTOR(1 downto 0);
        amp_switch                      : in STD_LOGIC_VECTOR(1 downto 0);
        chirp_sw                        : in std_logic;
        readyy                          : out STD_LOGIC;
        ac_adc_sdata                    : in STD_LOGIC;
        ac_mclk                         : out STD_LOGIC;
        ac_dac_sdata                    : out STD_LOGIC;
        ac_bclk                         : out STD_LOGIC;
        ac_lrclk                        : out STD_LOGIC;
        scl                             : inout STD_LOGIC;
        sda                             : inout STD_LOGIC;
        sw_slot                         : out STD_LOGIC;
        cw_slot                         : in STD_LOGIC_VECTOR (4 downto 0)
        );

end lab4_datapath;

architecture Behavioral of lab4_datapath is

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
    

    signal phase_inc, in_off, index_offset         : signed(15 downto 0);
    signal index, next_index, offset               : signed(7 downto 0);
    signal base_value, next_value, delta           : signed(15 downto 0);
    signal BRAM_addr                               : std_logic_vector(9 downto 0);
    signal DO_output                               : std_logic_vector(15 downto 0);
    signal reset                                   : std_logic;
	signal delta_offset, interpol_val              : signed(15 downto 0);
	signal offset_sig                              : signed(8 downto 0);
	signal del_off                                 : signed(24 downto 0);
	signal amplified_interpol, amplified_uninterpol: signed(17 downto 0);
	signal amp_interpol_sig, amp_uninterpol_sig    : signed(20 downto 0);
	signal amplify                                 : signed(4 downto 0);
	
	signal count, count2                                   : unsigned(26 downto 0);
	
	signal Rbus_sig, Lbus_sig                      : STD_LOGIC_VECTOR(17 downto 0);
	signal sim_live                                : std_logic;
    signal chirp                                   : integer;
    signal var                                     : integer;
    
begin

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
            ready => readyy,
            L_bus_in => Lbus_sig, -- left channel input to DAC
            R_bus_in => Rbus_sig, -- right channel input to DAC
            L_bus_out => OPEN, -- left channel output from ADC
            R_bus_out => OPEN, -- right channel output from ADC
            scl => scl,
            sda => sda,
            sim_live => sim_live);  --  '0' simulate audio; '1' live audio
    
    
    sim_live <= '0';
    
    
	-----------------------------------------------------------------------------
    --        This counter increments the Address going to BRAM 
    --      cw(1), cw(0)
    --        00            hold
    --        01            count up
    --        10            unused
    --        11            synch reset
    -----------------------------------------------------------------------------
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (reset_n = '0') then
                count <= (others => '0');
                
            elsif (count = 2500000) then--25000000) then
                count <= (others => '0');
                
            else
                count <= count + 1;
                
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (reset_n = '0') then
                count2 <= (others => '0');
                
            elsif (count2 = 36300000) then--25000000) then
                count2 <= (others => '0');
                
            else
                count2 <= count2 + 1;
                
            end if;
        end if;
    end process;
    

     -----------------------------------------------------------------------------
    -- Implements the comparator to tell the FSM when we have finished reading memory
     -----------------------------------------------------------------------------
    sw_slot <= '1' when (count = 2500000) else '0';
--    sw_slot(0) <= '1' when (count = 1000000) else '0';
--    sw_slot(1) <= '1' when (count = 1000000) else '0';
    
    
--    phase_inc <= "0000001011001100" when cw_slot = "000" else       -- 440Hz
--                 "0000001100010011" when cw_slot = "001" else       -- x = 00000001.00000000
--                 "0000001110000101" when cw_slot = "010" else       -- 2 cycles
--                 "0000001110111001" when cw_slot = "011" else       -- 440Hz
--                 "0000010000101110" when cw_slot = "100" else       -- x = 00000001.00000000
--                 "0000010010110001" when cw_slot = "101" else
--                 "0000010101000100" when cw_slot = "110";           -- interpolated wave(10Hz) 
    phase_inc <=        -- 440Hz
 
   
             "0000100001011100" when cw_slot = "00001" else       -- x = 00000001.00000000
             "0000101100101001" when cw_slot = "00010" else       -- 2 cycles
             "0000110010000111" when cw_slot = "00011" else       -- 440Hz
             "0000111000010000" when cw_slot = "00100" else       -- x = 00000001.00000000
             "0000110010000111" when cw_slot = "00101" else
             "0000101010001001" when cw_slot = "00110" else  
             "0000111000010000" when cw_slot = "00111" else       -- x = 00000001.00000000
             "0000111111001001" when cw_slot = "01000" else       -- 2 cycles
             "0001000110110111" when cw_slot = "01001" else       -- 440Hz
             "0000111111001001" when cw_slot = "01010" else       -- x = 00000001.00000000
             "0010010000010010" when cw_slot = "01011" else
             
             "0000001000110111" when cw_slot = "01100" else
             "0000001100010011" when cw_slot = "01101" else       -- x = 00000001.00000000
             "0000001000110111" when cw_slot = "01110" else       -- 2 cycles
             "0000001110111001" when cw_slot = "01111" else       -- 440Hz
             "0000001000110111" when cw_slot = "10000" else       -- x = 00000001.00000000
             "0000010010110001" when cw_slot = "01000" else
             "0000001000110111" when cw_slot = "01001"; 
    
    process(clk)
        begin
            if (rising_edge(clk)) then
                if (chirp_sw = '1') then
                    if (var < 500000) then
                        var <= var + 1;
                    else
                        var <= 0;
                        chirp <= chirp + 1;
                    end if;
                else 
                    var <= 0;
                    chirp <= 0;
                end if;
            end if;
    end process;
                    
    in_off <= index_offset + phase_inc + chirp;
    

    process (clk)
        begin
            if (rising_edge(clk)) then
                if reset_n = '0' then
                    index_offset <= (others => '0');
                elsif (cw(0) = '1') then
                    index_offset <= in_off;
                end if;
            end if;
    end process;       
    
    index <= index_offset(15 downto 8);
    
    next_index <= index + "00000001";
       
    offset <= index_offset(7 downto 0);

    
    --MUX for BRAM address
    BRAM_addr <= std_logic_vector("00" & index) when cw(1) = '0' else std_logic_vector("00" & next_index);
    
    	-------------------------------------------------------------------------------
    -- Instantiate a left and right BRAM
    -------------------------------------------------------------------------------
    reset <= not reset_n;
    
    leftChannelMemory : BRAM_SDP_MACRO
        generic map (
            BRAM_SIZE => "18Kb",            -- Target BRAM, "18Kb" or "36Kb"
            DEVICE => "7SERIES",            -- Target device: "VIRTEX5", "VIRTEX6", "SPARTAN6", "7SERIES"
            DO_REG => 0,                    -- Optional output register (0 or 1)
            INIT => X"000000000000000000",            -- Initial values on output port
            INIT_FILE => "NONE",            -- Initial values on output port
            WRITE_WIDTH => 16,              -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
            READ_WIDTH => 16,               -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
            SIM_COLLISION_CHECK => "NONE",  -- Collision check enable "ALL", "WARNING_ONLY", "GENERATE_X_ONLY" or "NONE"
            SRVAL => X"000000000000000000", -- Set/Reset value for port output
            -- Here is where you insert the INIT_xx declarations to specify the initial contents of the RAM
            INIT_00 => X"AE10AB1FA826A527A2239F199C0B98F895E192C78FAB8C8B896A864783248000",
            INIT_01 => X"D842D5F5D39AD133CEBFCC3FC9B3C71CC47AC1CDBF17BC56B98CB6B9B3DEB0FB",
            INIT_02 => X"F504F3B5F254F0E2EF5EEDC9EC23EA6DE8A6E6CFE4E8E2F1E0EBDED7DCB3DA82",
            INIT_03 => X"FFF5FFD8FFA6FF61FF09FE9CFE1DFD89FCE3FC29FB5CFA7CF989F884F76BF641",
            INIT_04 => X"F76BF884F989FA7CFB5CFC29FCE3FD89FE1DFE9CFF09FF61FFA6FFD8FFF5FFFF",
            INIT_05 => X"DCB3DED7E0EBE2F1E4E8E6CFE8A6EA6DEC23EDC9EF5EF0E2F254F3B5F504F641",
            INIT_06 => X"B3DEB6B9B98CBC56BF17C1CDC47AC71CC9B3CC3FCEBFD133D39AD5F5D842DA82",
            INIT_07 => X"83248647896A8C8B8FAB92C795E198F89C0B9F19A223A527A826AB1FAE10B0FB",
            INIT_08 => X"51EF54E057D95AD85DDC60E663F467076A1E6D3870547374769579B87CDB8000",
            INIT_09 => X"27BD2A0A2C652ECC314033C0364C38E33B853E3240E843A9467349464C214F04",
            INIT_0A => X"0AFB0C4A0DAB0F1D10A1123613DC1592175919301B171D0E1F142128234C257D",
            INIT_0B => X"000A00270059009E00F6016301E20276031C03D604A305830676077B089409BE",
            INIT_0C => X"0894077B0676058304A303D6031C027601E2016300F6009E00590027000A0000",
            INIT_0D => X"234C21281F141D0E1B1719301759159213DC123610A10F1D0DAB0C4A0AFB09BE",
            INIT_0E => X"4C214946467343A940E83E323B8538E3364C33C031402ECC2C652A0A27BD257D",
            INIT_0F => X"7CDB79B87695737470546D386A1E670763F460E65DDC5AD857D954E051EF4F04",
            INIT_10 => X"AE10AB1FA826A527A2239F199C0B98F895E192C78FAB8C8B896A864783247FFF",
            INIT_11 => X"D842D5F5D39AD133CEBFCC3FC9B3C71CC47AC1CDBF17BC56B98CB6B9B3DEB0FB",
            INIT_12 => X"F504F3B5F254F0E2EF5EEDC9EC23EA6DE8A6E6CFE4E8E2F1E0EBDED7DCB3DA82",
            INIT_13 => X"FFF5FFD8FFA6FF61FF09FE9CFE1DFD89FCE3FC29FB5CFA7CF989F884F76BF641",
            INIT_14 => X"F76BF884F989FA7CFB5CFC29FCE3FD89FE1DFE9CFF09FF61FFA6FFD8FFF5FFFF",
            INIT_15 => X"DCB3DED7E0EBE2F1E4E8E6CFE8A6EA6DEC23EDC9EF5EF0E2F254F3B5F504F641",
            INIT_16 => X"B3DEB6B9B98CBC56BF17C1CDC47AC71CC9B3CC3FCEBFD133D39AD5F5D842DA82",
            INIT_17 => X"83248647896A8C8B8FAB92C795E198F89C0B9F19A223A527A826AB1FAE10B0FB",
            INIT_18 => X"51EF54E057D95AD85DDC60E663F467076A1E6D3870547374769579B87CDB8000",
            INIT_19 => X"27BD2A0A2C652ECC314033C0364C38E33B853E3240E843A9467349464C214F04",
            INIT_1A => X"0AFB0C4A0DAB0F1D10A1123613DC1592175919301B171D0E1F142128234C257D",
            INIT_1B => X"000A00270059009E00F6016301E20276031C03D604A305830676077B089409BE",
            INIT_1C => X"0894077B0676058304A303D6031C027601E2016300F6009E00590027000A0000",
            INIT_1D => X"234C21281F141D0E1B1719301759159213DC123610A10F1D0DAB0C4A0AFB09BE",
            INIT_1E => X"4C214946467343A940E83E323B8538E3364C33C031402ECC2C652A0A27BD257D",
            INIT_1F => X"7CDB79B87695737470546D386A1E670763F460E65DDC5AD857D954E051EF4F04",
            INIT_20 => X"AE10AB1FA826A527A2239F199C0B98F895E192C78FAB8C8B896A864783247FFF",
            INIT_21 => X"D842D5F5D39AD133CEBFCC3FC9B3C71CC47AC1CDBF17BC56B98CB6B9B3DEB0FB",
            INIT_22 => X"F504F3B5F254F0E2EF5EEDC9EC23EA6DE8A6E6CFE4E8E2F1E0EBDED7DCB3DA82",
            INIT_23 => X"FFF5FFD8FFA6FF61FF09FE9CFE1DFD89FCE3FC29FB5CFA7CF989F884F76BF641",
            INIT_24 => X"F76BF884F989FA7CFB5CFC29FCE3FD89FE1DFE9CFF09FF61FFA6FFD8FFF5FFFF",
            INIT_25 => X"DCB3DED7E0EBE2F1E4E8E6CFE8A6EA6DEC23EDC9EF5EF0E2F254F3B5F504F641",
            INIT_26 => X"B3DEB6B9B98CBC56BF17C1CDC47AC71CC9B3CC3FCEBFD133D39AD5F5D842DA82",
            INIT_27 => X"83248647896A8C8B8FAB92C795E198F89C0B9F19A223A527A826AB1FAE10B0FB",
            INIT_28 => X"51EF54E057D95AD85DDC60E663F467076A1E6D3870547374769579B87CDB8000",
            INIT_29 => X"27BD2A0A2C652ECC314033C0364C38E33B853E3240E843A9467349464C214F04",
            INIT_2A => X"0AFB0C4A0DAB0F1D10A1123613DC1592175919301B171D0E1F142128234C257D",
            INIT_2B => X"000A00270059009E00F6016301E20276031C03D604A305830676077B089409BE",
            INIT_2C => X"0894077B0676058304A303D6031C027601E2016300F6009E00590027000A0000",
            INIT_2D => X"234C21281F141D0E1B1719301759159213DC123610A10F1D0DAB0C4A0AFB09BE",
            INIT_2E => X"4C214946467343A940E83E323B8538E3364C33C031402ECC2C652A0A27BD257D",
            INIT_2F => X"7CDB79B87695737470546D386A1E670763F460E65DDC5AD857D954E051EF4F04",
            INIT_30 => X"AE10AB1FA826A527A2239F199C0B98F895E192C78FAB8C8B896A864783247FFF",
            INIT_31 => X"D842D5F5D39AD133CEBFCC3FC9B3C71CC47AC1CDBF17BC56B98CB6B9B3DEB0FB",
            INIT_32 => X"F504F3B5F254F0E2EF5EEDC9EC23EA6DE8A6E6CFE4E8E2F1E0EBDED7DCB3DA82",
            INIT_33 => X"FFF5FFD8FFA6FF61FF09FE9CFE1DFD89FCE3FC29FB5CFA7CF989F884F76BF641",
            INIT_34 => X"F76BF884F989FA7CFB5CFC29FCE3FD89FE1DFE9CFF09FF61FFA6FFD8FFF5FFFF",
            INIT_35 => X"DCB3DED7E0EBE2F1E4E8E6CFE8A6EA6DEC23EDC9EF5EF0E2F254F3B5F504F641",
            INIT_36 => X"B3DEB6B9B98CBC56BF17C1CDC47AC71CC9B3CC3FCEBFD133D39AD5F5D842DA82",
            INIT_37 => X"83248647896A8C8B8FAB92C795E198F89C0B9F19A223A527A826AB1FAE10B0FB",
            INIT_38 => X"51EF54E057D95AD85DDC60E663F467076A1E6D3870547374769579B87CDB8000",
            INIT_39 => X"27BD2A0A2C652ECC314033C0364C38E33B853E3240E843A9467349464C214F04",
            INIT_3A => X"0AFB0C4A0DAB0F1D10A1123613DC1592175919301B171D0E1F142128234C257D",
            INIT_3B => X"000A00270059009E00F6016301E20276031C03D604A305830676077B089409BE",
            INIT_3C => X"0894077B0676058304A303D6031C027601E2016300F6009E00590027000A0000",
            INIT_3D => X"234C21281F141D0E1B1719301759159213DC123610A10F1D0DAB0C4A0AFB09BE",
            INIT_3E => X"4C214946467343A940E83E323B8538E3364C33C031402ECC2C652A0A27BD257D",
            INIT_3F => X"7CDB79B87695737470546D386A1E670763F460E65DDC5AD857D954E051EF4F04")
    port map (
            DO => DO_output,    -- Output read data port, width defined by READ_WIDTH parameter
            RDADDR => BRAM_addr,-- Input address, width defined by port depth
            RDCLK => clk,                   -- 1-bit input clock
            RST => reset,                 -- active high reset
            RDEN => '1',                    -- read enable
            REGCE => '1',                   -- 1-bit input read output register enable
            DI => "1111111111111111",                   -- Input data port, width defined by WRITE_WIDTH parameter
            WE => "00",                     -- Input write enable, width defined by write port depth
            WRADDR => "0000000000", -- Right_WRADDR_sig,                -- Input write address, width defined by write port depth
            WRCLK => clk,                   -- 1-bit input write clock
            WREN => '0');              -- 1-bit input write port enable
            -- End of BRAM_SDP_MACRO_inst instantiation

 ------------------------------------------------------------------------------
	-- Buffer register to keep track of base BRAM data value
	------------------------------------------------------------------------------ 
	
    process (clk)
        begin
            if (rising_edge(clk)) then
                if reset_n = '0' then
                    base_value <= (others => '0');
                    next_value <= (others => '0');
                elsif(cw(2) = '1') then
                    base_value <= signed(DO_output) - x"8000";
                elsif(cw(3) = '1') then
                    next_value <= signed(DO_output)- x"8000";
                end if;
            end if;
    end process;    
    
    delta <= next_value - base_value;
    offset_sig <= '0' & offset;
    
    del_off <= delta * offset_sig;
    
    delta_offset <= del_off(23 downto 8);
    
    interpol_val <= base_value + delta_offset;
    
    amplify <= "00001" when amp_switch = "00" else --0.50
               "00011" when amp_switch = "01" else --0.75
               "00100" when amp_switch = "10" else --1.00
               "00101" when amp_switch = "11";     --1.25   
    
    amp_interpol_sig <= interpol_val * amplify;
    amp_uninterpol_sig <= base_value * amplify;
    
    Rbus_sig <= std_logic_vector (amp_interpol_sig(19 downto 2));
    Lbus_sig <= std_logic_vector (amp_interpol_sig(19 downto 2));
    
end Behavioral;