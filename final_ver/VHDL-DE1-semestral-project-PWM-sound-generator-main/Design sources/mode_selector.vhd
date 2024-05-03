library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mode_selector is
    Port (
        switch : in  STD_LOGIC; -- Assuming 1 switch
        pos_freq: in std_logic_vector (4 downto 0);
        pos_duty: in std_logic_vector (4 downto 0);
        pos_out: out std_logic_vector (4 downto 0)
    );
end mode_selector;

architecture Behavioral of mode_selector is
begin
    process(switch)
    begin
        if switch = '0' then
            pos_out <= pos_freq;
        else
            pos_out <= pos_duty;
        end if;
    end process;
end Behavioral;

