library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity duty is
    port(
        clear : in    std_logic;                    --! Clear the display
        en : in   std_logic;                    --! Enable the display
--        clk : in      std_logic;                    --! Clock signal
--        freq_bin : out    std_logic_vector(14 downto 0);  --! duty of the display
        pos_duty : out     std_logic_vector(1 downto 0);  --! Current working position
        left : in     std_logic;                    --! Move to the left
        right : in    std_logic;                    --! Move to the right
        increment : in std_logic;                    --! Increment the duty
        decrement : in std_logic;                    --! Decrement the duty
        out_1 : out std_logic_vector(3 downto 0);  --! Output for the next stage
        out_10 : out std_logic_vector(3 downto 0)  --! Output for the next stage
    );

end entity duty;



architecture behavioral of duty is

signal int_duty : integer := 50;
signal int_pos : integer := 1;

begin

    val_change: process(increment, decrement, clear) is   --! Process to change the value of the duty
    begin
        if clear = '1' then
            int_duty <= 50;
        else
            if increment = '1' then
                int_duty <= int_duty + 1 * (10 ** int_pos);
                if int_duty > 100 then
                    int_duty <= 100;
                end if;
            elsif decrement = '1' then
                int_duty <= int_duty - 1 * (10 ** int_pos);
                if int_duty < 0 then
                    int_duty <= 0;
                end if;
            end if;
        end if;
     end process val_change;
     
    pos_change: process(left, right, clear) is   --! Process to change the position of the duty
    begin
        if clear = '1' then
            int_pos <= 1;
        else
            if left = '1' then
                int_pos <= int_pos + 1;
                if int_pos > 1 then
                    int_pos <= 1;
                end if;
            elsif right = '1' then
                int_pos <= int_pos - 1;
                if int_pos < 0 then
                    int_pos <= 0;
                end if;
            end if;
        end if;
    end process pos_change;

    process (int_pos) is
    begin
        case int_pos is
            when 0 =>
                pos_duty <= "01";
            when 1 =>
                pos_duty <= "10";
            when others =>
                pos_duty <= "00";
        end case;
    end process;

--    freq_bin <= std_logic_vector(to_unsigned(int_duty, 15));

    out_1 <= std_logic_vector(to_unsigned(int_duty mod 10, 4));
    out_10 <= std_logic_vector(to_unsigned((int_duty / 10) mod 10, 4));

-- TODO: Make the duty more readable for the next stage, maybe a 4 bit std_logic_vector for every decade
end behavioral;
