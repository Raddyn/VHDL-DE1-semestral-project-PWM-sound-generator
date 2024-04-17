----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.04.2024 16:08:18
-- Design Name: 
-- Module Name: clock_enable - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_enable is
    generic (
        N_PERIODS : integer := 6);
        
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pulse : out STD_LOGIC);
end clock_enable;

architecture Behavioral of clock_enable is
    signal sig_count : integer range 0 to N_PERIODS-1;
begin
    --! Count the number of clock pulses from zero to N_PERIODS-1.
    p_clk_enable : process (clk) is
    begin

        -- Synchronous proces
        if (rising_edge(clk)) then
            if (rst = '1') then
                -- Clear integer counter
                sig_count <= 0;
            elsif (sig_count <  N_PERIODS - 1) then
                -- Counting
                sig_count <= sig_count + 1;

            else 
                -- Clear integer counter
                sig_count <= 0;
            end if;
        end if;

    end process p_clk_enable;

    -- Generated pulse is always one clock long
    -- when sig_count = N_PERIODS-1
    pulse <= '1' when (sig_count = N_PERIODS - 1) else '0';
end Behavioral;
