--------------------------------------------------------------------------------
-- Name:	Dan Agalakotuwa
-- Date:	Jan 29, 2024
-- File:	vga_Dan.vhdl
-- Lab:     1
-- Crs:	    ECE 383
--
-- Purp:	VGA achitecture of the schematic to implement a o'scope grid
--
-- Documentation:	- C2C Flachmann pointed out that the hatches for columns
--                    start from 20 so that needs to be considered when using 
--                    mod to display the column hatches.
--                  - C2C Park helped me understand how the state machine needs
--                    to work for trigger_volt and trigger_time using a diagram
--                    and pointed me to the code provided in Lecture 9 on an
--                    example of a state machine (course website). He also helped
--                    me understand the difference between ch1 and ch1_enb.
--
-- Academic Integrity Statement: I certify that, while others may have 
-- assisted me in brain storming, debugging and validating this program, 
-- the program itself is my own work. I understand that submitting code 
-- which is the work of other individuals is a violation of the honor   
-- code.  I also understand that if I knowingly give my original work to 
-- another individual is also a violation of the honor code. 
--------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga is
	Port(	clk          : in  std_logic;
			reset_n      : in  std_logic;
			h_sync       : out  std_logic;
			v_sync       : out  std_logic; 
			blank        : out  std_logic;
			r            : out std_logic_vector(7 downto 0);
			g            : out std_logic_vector(7 downto 0);
			b            : out std_logic_vector(7 downto 0);
			trigger_time : in unsigned(9 downto 0);
			trigger_volt : in unsigned (9 downto 0);
			row          : out unsigned(9 downto 0);
			column       : out unsigned(9 downto 0);
			ch1          : in std_logic;
			ch1_enb      : in std_logic;
			ch2          : in std_logic;
			ch2_enb      : in std_logic);
end vga;

architecture behavior of vga is

    component counter_hori is
        Port(	clk_count_h  : in  std_logic;
	       		reset_n      : in  std_logic;
			    roll_h       : out std_logic;
			    Col          : out unsigned (9 downto 0));
	
	end component counter_hori;
	
    component counter_vert is
        Port(	clk_count_v  : in  std_logic;
			    reset_n      : in  std_logic;
			    ctrl         : in std_logic;
			    Row          : out unsigned (9 downto 0));
    end component counter_vert;
    
    component scopeface is
        Port(   row          : in  unsigned(9 downto 0);
                column       : in  unsigned(9 downto 0);
                trigger_volt : in unsigned (9 downto 0);
                trigger_time : in unsigned (9 downto 0);
                r            : out  std_logic_vector(7 downto 0);
                g            : out  std_logic_vector(7 downto 0);
                b            : out  std_logic_vector(7 downto 0);
                ch1          : in std_logic;
                ch1_enb      : in std_logic;
                ch2          : in std_logic;
                ch2_enb      : in std_logic);
        end component scopeface;

    signal ctrl_1        : std_logic;
    signal roll_h_sig    : std_logic;
    signal Col_sig       : unsigned(9 downto 0);
    signal Row_sig       : unsigned(9 downto 0);
    signal v_blank       : std_logic;
    signal h_blank       : std_logic;

    begin
    
-- PORTMAPS
    counter_hori_inst: counter_hori
        port map(
            clk_count_h      => clk,
            reset_n          => reset_n,
            roll_h           => roll_h_sig,
            Col              => Col_sig
            );
    
    counter_vert_inst: counter_vert
        port map(
            clk_count_v      => clk,
            reset_n          => reset_n,
            ctrl             => roll_h_sig,
            Row              => Row_sig
            );
            
    scopeface_inst: scopeface
        port map(
            row             => Row_sig,
            column          => Col_sig,
            trigger_volt    => trigger_volt,
            trigger_time    => trigger_time,
            r               => r,
            g               => g,
            b               => b,
            ch1             => ch1,
            ch1_enb         => ch1_enb,
            ch2             => ch2,
            ch2_enb         => ch2_enb
            );
            
        process(clk)
        begin
            if(rising_edge(clk)) then
                if (reset_n = '0') then                           
                    h_sync <= '0';
                    h_blank <= '0';                    
                end if;    
                
                if (Col_sig > 654) and (Col_sig < 751) then
                    h_sync <= '0';
                else 
                    h_sync <= '1';
                end if;
                
                if (Col_sig > 638) and (Col_sig < 799) then
                    h_blank <= '1';
                else
                    h_blank <= '0';
                end if;   
                        
            end if;
            
        end process;
        
        process(clk)
        begin
            if(rising_edge(clk)) then
                if (reset_n = '0') then                          
                    v_sync <= '0';
                    v_blank <= '0';
                end if;
                
                if (Row_sig < 490) or (Row_sig > 491) then
                    v_sync <= '1';
                else 
                    v_sync <= '0';
                end if;
                
                if (Row_sig > 479) then
                    v_blank <= '1';
                else 
                    v_blank <= '0';
                end if;        
            end if;
                
       end process;
-- CSA
row     <= Row_sig;
column  <= Col_sig;
blank   <= v_blank or h_blank;



end behavior;

