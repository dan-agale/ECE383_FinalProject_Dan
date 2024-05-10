-- By George York
-- try fool signed multiply into unsigned multiply

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNIMACRO;
use UNIMACRO.vcomponents.all;

entity interpolation_tb is

end interpolation_tb;

architecture Behavioral of interpolation_tb is

    component lab4 is
     Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
           ac_mclk : out STD_LOGIC;
           ac_adc_sdata : in STD_LOGIC;
           ac_dac_sdata : out STD_LOGIC;
           ac_bclk : out STD_LOGIC;
           ac_lrclk : out STD_LOGIC;
           scl : inout STD_LOGIC;
           sda : inout STD_LOGIC;
           tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0);
           switch: in    STD_LOGIC_VECTOR(7 downto 0);
           btn: in    STD_LOGIC_VECTOR(4 downto 0));
    end component;

	signal amp: signed(2 downto 0) := "011";
	signal interpolated, uninterpolated: signed(17 downto 0);
	signal clk, ready_sig : std_logic := '0';
    signal reset_n : std_logic := '0';
    
    signal ac_mclk : STD_LOGIC;
    signal ac_adc_sdata : STD_LOGIC;
    signal ac_dac_sdata :  STD_LOGIC;
    signal ac_bclk :  STD_LOGIC;
    signal ac_lrclk :  STD_LOGIC;
    signal scl :  STD_LOGIC;
    signal sda :  STD_LOGIC;
    signal tmds :   STD_LOGIC_VECTOR (3 downto 0);
    signal tmdsb :   STD_LOGIC_VECTOR (3 downto 0);
    signal switch:     STD_LOGIC_VECTOR(7 downto 0);
    signal btn:     STD_LOGIC_VECTOR(4 downto 0);
   
   constant clk_period : time := 10 ns;
	
begin

	lab4_gc2_tb: lab4
	port map(
        clk => clk,
        reset_n => reset_n,
        ac_mclk => ac_mclk,
        ac_adc_sdata => ac_adc_sdata,
        ac_dac_sdata => ac_dac_sdata,
        ac_bclk  => ac_bclk,
        ac_lrclk => ac_lrclk,
        scl => scl,
        sda  => sda,
        tmds  => tmds,
        tmdsb  => tmdsb,
        switch => switch,
        btn  => btn
        );

    clk_process0 :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;

        reset_n <= '0', '1' after 30nS;                   
        switch(0) <= '1';
        switch(1) <= '1';
        switch(2) <= '1';
        switch(4 downto 7) <= "1111";
end Behavioral;