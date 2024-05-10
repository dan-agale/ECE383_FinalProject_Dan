library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity unsign_to_sign is
    Port (
        input : in unsigned(7 downto 0);
        output : out signed(7 downto 0)
    );
end entity unsign_to_sign;

architecture Behavioral of unsign_to_sign is
    
    signal inter: unsigned(7 downto 0);
    
begin
    process(input)
    begin

            inter <= not(input);
            output <= signed(inter + "00000001");

    end process;
end architecture Behavioral;
