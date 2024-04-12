library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mode_selector is
    Port (
        switch : in  STD_LOGIC; -- Assuming 1 switch
        frequency_mode : out STD_LOGIC;
        duty_cycle_mode : out STD_LOGIC
    );
end mode_selector;

architecture Behavioral of mode_selector is
begin
    process(switch)
    begin
        if switch = '0' then
            frequency_mode <= '1'; -- Mode 1 output is HIGH
            duty_cycle_mode <= '0'; -- Mode 2 output is LOW
        else
            frequency_mode <= '0'; -- Mode 1 output is LOW
            duty_cycle_mode <= '1'; -- Mode 2 output is HIGH
        end if;
    end process;
end Behavioral;

