--------------------------------------------------------------------
-- Name:	George York
-- Date:	Jan 9, 2021
-- File:	convert_unsigned_tb.vhdl
-- HW:	    Lecture 3
-- Crs:	    ECE 383
--
-- Purp:	This is a testbench to test converting from signed to unsigned
--
--
-- Academic Integrity Statement: I certify that, while others may have 
-- assisted me in brain storming, debugging and validating this program, 
-- the program itself is my own work. I understand that submitting code 
-- which is the work of other individuals is a violation of the honor   
-- code.  I also understand that if I knowingly give my original work to 
-- another individual is also a violation of the honor code. 
------------------------------------------------------------------------- 
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY convert_unsigned_tb IS
END convert_unsigned_tb;
 
ARCHITECTURE behavior OF convert_unsigned_tb IS 
 

	CONSTANT	TEST_ELEMENTS:integer:=5;
	
	-- 5 test cases like the numbers in the table on lab2 slide 11
	-- Code below if for testing UNSIGNED math
	SUBTYPE io_signed is signed(3 downto 0);
	TYPE TEST_signed is array (1 to TEST_ELEMENTS) of io_signed;
	SIGNAL TESTA_s: TEST_signed := ("1000", "1111", "0000", "0001", "0111");
	
	SUBTYPE io_unsigned is unsigned(3 downto 0);
	TYPE TEST_unsigned is array (1 to TEST_ELEMENTS) of io_unsigned;
	SIGNAL TESTA_u: TEST_unsigned := ("0000", "0111", "1000", "1001", "1111");
	SIGNAL answer_U : io_unsigned;

	-- Code below if for testing STD_LOGIC_VECTOR math
	SUBTYPE io_signed_std_logic is std_logic_vector(3 downto 0);
	TYPE TEST_signed_std_logic is array (1 to TEST_ELEMENTS) of io_signed_std_logic;
	SIGNAL TESTA_s_std_logic: TEST_signed_std_logic := ("1000", "1111", "0000", "0001", "0111");
	
	SUBTYPE io_unsigned_std_logic is unsigned(3 downto 0);
	TYPE TEST_unsigned_std_logic is array (1 to TEST_ELEMENTS) of io_unsigned_std_logic;
	SIGNAL TESTA_u_std_logic: TEST_unsigned_std_logic := ("0000", "0111", "1000", "1001", "1111");
	SIGNAL answer_U_std_logic : io_unsigned_std_logic;
	
	SIGNAL i : integer;
 
BEGIN
 
	process is
	begin
 
		-------------------------------------------
		-- loop through all the test vectors and check
		-- they produce the correct output
		-------------------------------------------		
		for i in 1 to TEST_ELEMENTS loop
			-- put code to test conversion from signed to unsigned here	
			-- *** put your code here ***
			-- answer_U <= TESTA_s(i) + 5;
             answer_U <= unsigned(TESTA_s_std_logic(i) xor "1000");
			 
			wait for 1 us;

		end loop;
        wait;
		-------------------------------------------
		-- If the simulation finishes then halt the
		-- sim and let the user know all is well.
		-------------------------------------------
		assert TRUE = FALSE
			report "Correct circuit behavior - nominal performance."
			severity failure;
	end process tb;

end architecture behavior;
