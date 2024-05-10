--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

package graphicsParts is

component graphics
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
  		   tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component graphics_fsm
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
		   fsmCol: out std_logic_vector(5 downto 0);
           fsmRow: out std_logic_vector(4 downto 0);
           fsmWen : out std_logic;
           fsmData: out std_logic_vector(15 downto 0) );
end component;

component graphics_datapath
    Port ( clk : in  STD_LOGIC;
           reset_n : in  STD_LOGIC;
		   tmds : out  STD_LOGIC_VECTOR (3 downto 0);
           tmdsb : out  STD_LOGIC_VECTOR (3 downto 0);
		   fsmCol: in std_logic_vector(5 downto 0);
           fsmRow: in std_logic_vector(4 downto 0);
           fsmWen : in std_logic;
           fsmData: in std_logic_vector(15 downto 0);
			  exCol: in std_logic_vector(5 downto 0);
			  exRow: in std_logic_vector(4 downto 0);
			  exWen, exSel: in std_logic;
			  exData: in std_logic_vector(15 downto 0));
end component;


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
	

end graphicsParts;
