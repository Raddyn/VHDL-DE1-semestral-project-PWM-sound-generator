library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity encoder is
    port(
        clk : in std_logic;
        data_A : in std_logic;
        data_B : in std_logic;
        Up : out std_logic;
        down : out std_logic
    );
end encoder;



architecture Behavioral of encoder is
signal count : std_logic_vector(1 downto 0) := "00";
signal count_int : integer;
signal previous_count_int : integer;

begin


process(clk)
begin
    if rising_edge(clk) then
    case count is
        when "00" =>
            count_int <= 0;
        when "01" =>
            count_int <= 1;
        when "11" =>
            count_int <= 2;
        when "10" =>
            count_int <= 3;
        when others =>
            count_int <= 0;
    end case;
        if -count_int+previous_count_int > 0 then
            Up <= '1';
            down <= '0';
        elsif -count_int+previous_count_int < 0 then
            Up <= '0';
            down <= '1';
        else
            Up <= '0';
            down <= '0';
        end if;
        previous_count_int <= count_int;
    end if;


count(0) <= data_A;
count(1) <= data_B;
end process;

end Behavioral;
