----------------------------------------------------------------------------------
-- Name:	Dananga Agalakotuwa
-- Date:	May 2024
-- File:    lab4.vhd
-- HW:	    Reused from Lab 4 for Final Project
-- Pupr:	This is the top level to achieve all Lab 4 functionality. It has 4
--          seperate components within it; lab 2 datapath, lab 4 datapath, lab 2
--          fsm, and lab4 fsm.
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNIMACRO;
use UNIMACRO.vcomponents.all;

 entity lab4 is
        Port (
            clk         : in STD_LOGIC;
            reset_n     : in STD_LOGIC;
		    ac_adc_sdata: in STD_LOGIC;	    
            ac_mclk     : out STD_LOGIC;
            ac_dac_sdata: out STD_LOGIC;
            ac_bclk     : out STD_LOGIC;
            ac_lrclk    : out STD_LOGIC;
            scl         : inout STD_LOGIC;
            sda         : inout STD_LOGIC;
            winFlag     : in STD_LOGIC
        );
 end lab4;

architecture behavior of lab4 is

    component lab4_datapath is
        port (
        clk                             : in STD_LOGIC;
        reset_n                         : in STD_LOGIC;
        cw                              : in STD_LOGIC_VECTOR(3 downto 0);
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
    end component;
    
    
    
    component lab4_fsm is
        Port (
            clk     : in STD_LOGIC;
            reset_n  : in STD_LOGIC;
            ready    : in STD_LOGIC;
            cw       : out STD_LOGIC_VECTOR (3 downto 0);
            winFlag  : in std_logic
        );
    end component;
    
    component slot_machine_fsm is
        Port ( clk      : in STD_LOGIC;
               reset_n  : in STD_LOGIC;
               sw_slot    : in STD_LOGIC;
               cw_slot       : out STD_LOGIC_VECTOR (4 downto 0));
    end component;

	signal cw_lab4                 : STD_LOGIC_VECTOR (3 downto 0);
	signal cw_lab2                 : STD_LOGIC_VECTOR (2 downto 0);
	signal sw_lab2                 : STD_LOGIC_VECTOR (2 downto 0);
	signal extern_Lbus, extern_Rbus: STD_LOGIC_VECTOR (17 downto 0);
	signal ready_sig               : STD_LOGIC;
	signal sw_slot_sig                 : std_logic;
	signal cw_slot_sig                 : std_logic_vector(4 downto 0);

begin
			 
	lab4_dp_inst: lab4_datapath
        port map(
            clk               => clk,
            reset_n           => reset_n,
            cw                => cw_lab4,
            ac_mclk       => ac_mclk,
            ac_adc_sdata    => ac_adc_sdata,
            ac_dac_sdata  => ac_dac_sdata,
            ac_bclk       => ac_bclk,
            ac_lrclk      => ac_lrclk,
            readyy        => ready_sig,
            scl           => scl,
            sda           => sda,
            sw_slot      => sw_slot_sig,
            cw_slot      => cw_slot_sig
        );
		
			  
	lab4_fsm_inst: lab4_fsm
        port map( 
            clk       => clk,
            reset_n   => reset_n,
            cw        => cw_lab4,
            ready     => ready_sig,
            winFlag   => winFlag --chnage this to slave reg
		);
		
    slot_machine_inst: slot_machine_fsm
        Port map(
           clk => clk,
           reset_n => reset_n,
           sw_slot => sw_slot_sig,
           cw_slot => cw_slot_sig
       );

end behavior;
