----------------------------------------------------------------------------------
-- Name:	George York
-- Date:	Spring 2020
-- File:    graphics_datapath.vhd
-- HW:	    GRID MEMORY example: 2 bits per grid cell (really has 16 bits), for a 64 x 32 grid of 8x8 pixel cells, using 2 BRAMS
-- Pupr:	need to update!!!!.  
--
-- Doc:	Adapted from Dr Coulston's Lab exercise
-- 	
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNIMACRO;
use UNIMACRO.vcomponents.all;
use work.GraphicsParts.all;		
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity graphics_datapath is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0);
           exCol : in  STD_LOGIC_VECTOR (4 downto 0);
           exRow : in  STD_LOGIC_VECTOR (3 downto 0);
           exWen : in  STD_LOGIC;
           exData : in  STD_LOGIC_VECTOR (15 downto 0));
end graphics_datapath;

architecture Behavioral of graphics_datapath is
	
component video is
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0);
			  row: out unsigned(9 downto 0);
			  column: out unsigned(9 downto 0);
			  ch1 : in  std_logic_vector(15 downto 0);
			  ch1_enb: in std_logic;
			  ch2: in std_logic;
			  ch2_enb: in std_logic;
			  v_synch: out std_logic);
end component;

	signal ch2, reset: std_logic;
	signal cell_image : std_logic_vector(15 downto 0);
	signal row, column: unsigned(9 downto 0);
    signal graphic_write_addr, graphic_read_addr: std_logic_vector(9 downto 0);
	signal v_synch : std_logic;


begin

	reset <= not reset_n;

    graphic_write_addr <= '0' & exRow & exCol;

    

	-----------------------------------------------------------------------------------------
    -- BRAM_SDP_MACRO: 
	--     Store enough samples to display at least one sweep of the monitor [640x480]
	--         The RAM has 18kb (kilo BITS).  So if each word is
	--	       16 bits wide, this means that we will have 1k words per BRAM and need 10 bits of address.
	--         We are encoding 2-bits per pixel, so a 16 bit word will contain 8 pixels.
	--         The lower 512 BRAM entries will make a 8 pixel wide column (8 columns),
	--         and the higher 512 BRAM entries will make the adjacent 8 pixel wide column (8 columns).
	--         Therefore, to fill all 640 columns, we will need 40 BRAMs.
	-----------------------------------------------------------------------------------------

	
	BRAM0 : BRAM_SDP_MACRO   -- 16 bits wide x 1024 entries = 16,384 bits, so inside 18Kb
		generic map (
            BRAM_SIZE => "18Kb",            -- Target BRAM, "18Kb" or "36Kb"
            DEVICE => "7SERIES",            -- Target device: "VIRTEX5", "VIRTEX6", "SPARTAN6", "7SERIES"
            DO_REG => 0,                    -- Optional output register (0 or 1)
            --INIT => X"000000000000000000",  -- Initial values on output port
            INIT_FILE => "NONE",            -- Initial values on output port
            WRITE_WIDTH => 16,              -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
            READ_WIDTH => 16,               -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
            SIM_COLLISION_CHECK => "NONE",  -- Collision check enable "ALL", "WARNING_ONLY", "GENERATE_X_ONLY" or "NONE"
            SRVAL => X"000000000000000000", -- Set/Reset value for port output
            -- Here is where you insert the INIT_xx declarations to specify the initial contents of the RAM
            INIT_00 => X"8BC28AFA8A31896988A087D8870F8646857D84B583EC8323825A819180C87FFF",
            INIT_01 => X"A74FA777A79AA7B7A7CEA7DFA7EAA7EEA7ECA7E4A7D5A7BFA7A3A77FA7547FFF",
            INIT_02 => X"A269A2D1A337A39AA3FBA458A4B1A507A55AA5A8A5F2A638A67AA6B6A6EE7FFF",
            INIT_03 => X"9B369BAB9C209C959D0C9D829DF89E6E9EE49F599FCDA041A0B2A123A192A1FE",
            INIT_04 => X"94FD954B959C95F1964A96A59704976597C9983098999904997199E09A519AC3",
            INIT_05 => X"92729276927F928E92A192BA92D892FA9321934D937E93B393ED942B946D94B3",
            INIT_06 => X"950794B6946A942493E293A6936F933E931292EB92C992AD92979286927A9273",
            INIT_07 => X"9C869BF19B5E9ACF9A4499BC993998B9983E97C7975496E6967D961895B8955D",
            INIT_08 => X"A719A667A5B4A503A452A3A1A2F2A245A199A0EEA0469FA09EFC9E5A9DBB9D1F",
            INIT_09 => X"B1B3B11AB07EAFDFAF3DAE99ADF2AD48AC9DABF0AB42AA92A9E2A930A87EA7CC",
            INIT_0A => X"B8CFB888B83AB7E6B78BB72BB6C5B659B5E8B571B4F6B476B3F1B367B2DAB248",
            INIT_0B => X"B948B97EB9ABB9CFB9EBB9FFBA0ABA0DBA08B9FBB9E7B9CAB9A6B97BB949B90F",
            INIT_0C => X"B126B1ECB2A9B35EB409B4ABB544B5D3B65AB6D7B74BB7B7B819B872B8C2B909",
            INIT_0D => X"A020A16EA2B4A3F3A529A657A77EA89CA9B1AABEABC3ACBFADB2AE9CAF7EB056",
            INIT_0E => X"87C789768B218CC68E6790039199932A94B4963997B7992F9AA19C0B9D6F9ECB",
            INIT_0F => X"6B356D0A6EE070B57288745B762C77FB79C87B927D5B7F2080E282A1845C8614",
            INIT_10 => X"4E6D502751E453A55569573058F95AC65C945E646036620963DD65B36788695E",
            INIT_11 => X"358236E2384A39B83B2D3CA93E2A3FB3414042D4446D460C47B049584B054CB7",
            INIT_12 => X"23B7249425792667275F285F29672A782B922CB42DDE2F11304B318E32D83429",
            INIT_13 => X"1AD21B1C1B6E1BCA1C2F1C9D1D141D941E1E1EB11F4D1FF220A12159221A22E4",
            INIT_14 => X"1AC71A8C1A581A2C1A0719EB19D619C919C419C819D419E91A061A2C1A5A1A92",
            INIT_15 => X"21CC213420A020121F871F021E821E071D921D231CB91C561BF81BA21B521B09",
            INIT_16 => X"2CD82C1A2B5D2AA129E5292C287427BD2709265725A724FB245123AA23072267",
            INIT_17 => X"386637B9370B365935A634F03439338032C6320A314E30902FD22F142E552D96",
            INIT_18 => X"414E40DF406B3FF33F763EF53E6F3DE53D573CC63C303B973AFA3A5939B6390F",
            INIT_19 => X"458A456E454C452544F944C744904454441343CC4380432F42D9427E421D41B8",
            INIT_1A => X"44AE44DE450A453245554574458E45A445B545C145C845CB45C845C045B445A1",
            INIT_1B => X"3FF8405540B1410B416341B8420C425D42AC42F74340438643C844074442447A",
            INIT_1C => X"39FE3A583AB33B103B6F3BCE3C2F3C903CF13D533DB63E173E793EDA3F3B3F9A",
            INIT_1D => X"35FE361F3645367136A036D5370D3749378A37CE3815386038AD38FE395139A6",
            INIT_1E => X"370A36C7368C3658362A360435E435CB35B935AD35A735A735AD35B935CA35E1",
            INIT_1F => X"3F3A3E7C3DC73D193C733BD63B3F3AB13A2B39AC393538C5385E37FE37A53754",
            INIT_20 => X"4F134DE04CB34B8E4A6F49574846473D463B4540444D4361427D41A140CC3FFF",
            INIT_21 => X"655263CA624660C65F4A5DD35C615AF3598B582856CA5572541F52D3518D504D",
            INIT_22 => X"7F1E7D787BD37A2E788976E5754273A0720070616EC56D2B6B9369FE686C66DD",
            INIT_23 => X"989F971D9597940D928090EF8F5A8DC48C2A8A8E88F0875085AF840C826880C3",
            INIT_24 => X"ADCFACAEAB85AA55A91EA7E0A69BA54FA3FDA2A5A1469FE29E799D0A9B969A1D",
            INIT_25 => X"BB59BAC5BA28B981B8D0B816B753B687B5B1B4D3B3ECB2FCB203B102AFF9AEE8",
            INIT_26 => X"BF57BF61BF62BF59BF46BF29BF02BED1BE96BE51BE02BDAABD47BCDABC64BBE3",
            INIT_27 => X"B9B3BA4FBAE3BB6FBBF2BC6DBCDFBD48BDA7BDFEBE4CBE90BECBBEFCBF24BF42",
            INIT_28 => X"AC2BAD31AE32AF2EB024B114B1FEB2E2B3C0B498B568B632B6F4B7B0B863B90F",
            INIT_29 => X"99E09B169C4B9D7F9EB19FE1A10FA23AA363A489A5ABA6CBA7E6A8FEAA11AB21",
            INIT_2A => X"869D87C688F28A208B508C828DB58EEA90209157928F93C895009639977198A9",
            INIT_2B => X"75F876E077CE78C079B87AB47BB57CBB7DC57ED37FE580FB8215833284538576",
            INIT_2C => X"6A846B0D6B9C6C326CCE6D716E196EC86F7D703870F971C0728C735F74377514",
            INIT_2D => X"6546656D659965CB66036641668566CF671F677667D36836689F690F69856A01",
            INIT_2E => X"6588656465436526650D64F864E764DB64D364CF64D164D764E364F4650A6525",
            INIT_2F => X"691A68D768936851680F67CF678F6751671566DB66A3666D6639660965DB65B0",
            INIT_30 => X"6CEE6CBF6C8D6C586C216BE76BAC6B6F6B306AF06AAF6A6D6A2A69E669A2695E",
            INIT_31 => X"6DE86DFA6E086E106E146E126E0C6E026DF36DDF6DC86DAD6D8D6D6B6D446D1B",
            INIT_32 => X"69B06A216A8C6AF16B4F6BA76BF96C456C8B6CCA6D046D386D676D8F6DB26DD0",
            INIT_33 => X"5F5E602F60FB61C16281633C63F1649F654865EB6687671E67AE683868BC6939",
            INIT_34 => X"4FBD50D551E952FB540955135619571B581959135A075AF85BE35CCA5DAB5E87",
            INIT_35 => X"3D343E633F9140C041EE431C444A457646A247CC48F54A1C4B414C634D844EA2",
            INIT_36 => X"2B452C4C2D582E682F7C309331AE32CB33EC350E3634375B388439AE3ADA3C07",
            INIT_37 => X"1DBE1E641F121FC720842147221222E323BA2498257C26652754284929432A41",
            INIT_38 => X"17E217FA181D1849187E18BD1906195719B21A151A821AF71B741BFB1C891D1F",
            INIT_39 => X"1BA01B191A9C1A2919C01961190C18C118801849181C17FA17E117D217CE17D3",
            INIT_3A => X"2922280626F425E924E723EE22FE2217213920651F9A1ED81E201D711CCD1C32",
            INIT_3B => X"3EB43D2C3BAA3A2D38B5374435D83473331531BD306C2F222DDF2CA42B712A45",
            INIT_3C => X"5928576F55B75401524C50994EE94D3B4B8F49E7484246A04502436841D24041",
            INIT_3D => X"748072D8712C6F7E6DCE6C1B6A6768B166F96540638761CC60125E575C9C5AE1",
            INIT_3E => X"8CD18B738A0F88A5873685C0844682C681417FB87E2A7C977B01796677C77625",
            INIT_3F => X"9F199E2B9D369C399B349A29991597FB96D995B094809349920B90C67FFF8E29")
    port map (
            DO => cell_image,    -- Output read data port, width defined by READ_WIDTH parameter
            RDADDR => graphic_read_addr,-- Input address, width defined by port depth
            RDCLK => clk,                   -- 1-bit input clock
            RST => reset,                 -- active high reset
            RDEN => '1',                    -- read enable
            REGCE => '1',                   -- 1-bit input read output register enable
            DI => exData,    --wrLmux,                   -- Input data port, width defined by WRITE_WIDTH parameter
            WE => "11",                     -- Input write enable, width defined by write port depth
            --WE => "00",                     -- Input write enable, width defined by write port depth
            WRADDR => graphic_write_addr,                -- Input write address, width defined by write port depth
            WRCLK => clk,                   -- 1-bit input write clock
            WREN => exWen);              -- 1-bit input write port enable
            --WREN => wrEnbMux);              -- 1-bit input write port enable

            -- End of BRAM_SDP_MACRO_inst instantiation
	                
   	graphic_read_addr  <= std_logic_vector( '0' & row(8 downto 5) & column(9 downto 5));

    


	-------------------------------------------------------------------------------
	-- Instantiate the video driver from Lab1 - should integrate smoothly
	-------------------------------------------------------------------------------
	video_inst: video port map( 
		clk =>clk,
		reset_n => reset_n,
        tmds => tmds,
		tmdsb => tmdsb,
		row => row,
		column => column,
		ch1 => cell_image,
		ch1_enb => '1',
		ch2 => ch2,
		ch2_enb => ch2,
		v_synch => v_synch);



end Behavioral;

