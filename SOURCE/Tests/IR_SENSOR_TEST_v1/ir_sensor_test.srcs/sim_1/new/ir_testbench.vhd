library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ir_test_tb is
end ir_test_tb;

architecture sim of ir_test_tb is
    signal clk : std_logic := '0';
    signal reset_n : std_logic := '0';
    signal data : std_logic := '0';
    signal buttonScan : std_logic_vector(7 downto 0);

    constant clock_period : time := 10 ns; -- Adjust the clock period as needed

begin

    -- Instantiate the Unit Under Test (UUT)
    uut : entity work.ir_test
        port map (
            clk => clk,
            reset_n => reset_n,
            data => data,
            buttonScan => buttonScan
        );
        
    -- Clock process definitions
        clk_process : process
        begin
            while now < 100000 us loop -- Simulate for 1000 ns
                clk <= not clk;
                wait for clock_period / 2;
            end loop;
            wait;
        end process;

    -- Stimulus process
    stim_process : process
    begin
        wait for 5 us; -- Wait a bit for initialization

        -- Apply reset_n
        reset_n <= '1';
        wait for 10 us;

        -- simulate start bits
--        data <= '1';
--        wait for 5000 ns;
        data <= '0';
        wait for 2500 us;
        data <= '1';
        wait for 2500 us;
        data <= '0';
        wait for 2500 us;
        
 -------------------------------------       
        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;

        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;

        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;

        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;

        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a one
        data <= '1';
        wait for 1600 us;
        data <= '0';
        wait for 100 us;
        
        -- simulate a zero
        data <= '1';
        wait for 500 us;
        data <= '0';
        wait for 100 us;
        
 -------------------------------------    
        -- simulate end bit
        data <= '1';
        wait for 2000 us;

        -- End simulation
        wait;
    end process;

end sim;
