--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
--Date        : Tue May  7 15:15:57 2024
--Host        : Dans_Surface running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    DDR3_0_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR3_0_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR3_0_cas_n : out STD_LOGIC;
    DDR3_0_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_0_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_0_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_0_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_0_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    DDR3_0_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_0_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_0_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_0_ras_n : out STD_LOGIC;
    DDR3_0_reset_n : out STD_LOGIC;
    DDR3_0_we_n : out STD_LOGIC;
    JA_Port_0 : in STD_LOGIC;
    ac_adc_sdata_0 : in STD_LOGIC;
    ac_bclk_0 : out STD_LOGIC;
    ac_dac_sdata_0 : out STD_LOGIC;
    ac_lrclk_0 : out STD_LOGIC;
    ac_mclk_0 : out STD_LOGIC;
    reset : in STD_LOGIC;
    scl_0 : inout STD_LOGIC;
    sda_0 : inout STD_LOGIC;
    sys_clock : in STD_LOGIC;
    tmds_0 : out STD_LOGIC_VECTOR ( 3 downto 0 );
    tmdsb_0 : out STD_LOGIC_VECTOR ( 3 downto 0 );
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC;
    DDR3_0_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    DDR3_0_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_0_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_0_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR3_0_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR3_0_ras_n : out STD_LOGIC;
    DDR3_0_cas_n : out STD_LOGIC;
    DDR3_0_we_n : out STD_LOGIC;
    DDR3_0_reset_n : out STD_LOGIC;
    DDR3_0_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_0_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_0_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_0_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_0_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    reset : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    tmds_0 : out STD_LOGIC_VECTOR ( 3 downto 0 );
    tmdsb_0 : out STD_LOGIC_VECTOR ( 3 downto 0 );
    ac_mclk_0 : out STD_LOGIC;
    ac_dac_sdata_0 : out STD_LOGIC;
    ac_bclk_0 : out STD_LOGIC;
    ac_lrclk_0 : out STD_LOGIC;
    scl_0 : inout STD_LOGIC;
    sda_0 : inout STD_LOGIC;
    JA_Port_0 : in STD_LOGIC;
    ac_adc_sdata_0 : in STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      DDR3_0_addr(14 downto 0) => DDR3_0_addr(14 downto 0),
      DDR3_0_ba(2 downto 0) => DDR3_0_ba(2 downto 0),
      DDR3_0_cas_n => DDR3_0_cas_n,
      DDR3_0_ck_n(0) => DDR3_0_ck_n(0),
      DDR3_0_ck_p(0) => DDR3_0_ck_p(0),
      DDR3_0_cke(0) => DDR3_0_cke(0),
      DDR3_0_dm(1 downto 0) => DDR3_0_dm(1 downto 0),
      DDR3_0_dq(15 downto 0) => DDR3_0_dq(15 downto 0),
      DDR3_0_dqs_n(1 downto 0) => DDR3_0_dqs_n(1 downto 0),
      DDR3_0_dqs_p(1 downto 0) => DDR3_0_dqs_p(1 downto 0),
      DDR3_0_odt(0) => DDR3_0_odt(0),
      DDR3_0_ras_n => DDR3_0_ras_n,
      DDR3_0_reset_n => DDR3_0_reset_n,
      DDR3_0_we_n => DDR3_0_we_n,
      JA_Port_0 => JA_Port_0,
      ac_adc_sdata_0 => ac_adc_sdata_0,
      ac_bclk_0 => ac_bclk_0,
      ac_dac_sdata_0 => ac_dac_sdata_0,
      ac_lrclk_0 => ac_lrclk_0,
      ac_mclk_0 => ac_mclk_0,
      reset => reset,
      scl_0 => scl_0,
      sda_0 => sda_0,
      sys_clock => sys_clock,
      tmds_0(3 downto 0) => tmds_0(3 downto 0),
      tmdsb_0(3 downto 0) => tmdsb_0(3 downto 0),
      usb_uart_rxd => usb_uart_rxd,
      usb_uart_txd => usb_uart_txd
    );
end STRUCTURE;
