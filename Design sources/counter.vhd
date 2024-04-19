----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2024 10:26:01
-- Design Name: 
-- Module Name: counter - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    generic (
        count_int : integer := 0
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR (2 downto 0));
end counter;

architecture Behavioral of counter is
    signal sig_count: std_logic_vector(2 downto 0);
begin

    process (clk)
    begin
    if (rising_edge(clk)) then
        if rst='1' then
            sig_count <= (others => '0');
        elsif en = '1' then
            if sig_count < "100" then
                sig_count <= sig_count + 1;
            else
                sig_count <= (others => '0');
            end if;
        end if;
    end if;
    end process;

count <= sig_count;
end Behavioral;
