library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
entity duty is
  port
  (
    clear     : in std_logic; --! Clear the display
    en        : in std_logic; --! Enable the display
    pos_duty  : out std_logic_vector(4 downto 0); --! Current working position
    left      : in std_logic; --! Move to the left
    right     : in std_logic; --! Move to the right
    increment : in std_logic; --! Increment the duty
    decrement : in std_logic; --! Decrement the duty
    out_1     : out std_logic_vector(3 downto 0); --! Output for the next stage
    out_10    : out std_logic_vector(3 downto 0) --! Output for the next stage
  );

end entity duty;

architecture behavioral of duty is

  signal int_duty : integer := 50;
  signal int_pos  : integer := 1;

begin

  val_change : process (increment, decrement, clear) is --! Process to change the value of the duty
  begin
    if clear = '1' then
      int_duty <= 50;
    else
      if increment = '1' then
        case int_pos is
          when 0 =>
            if int_duty + 1 > 99 then
              int_duty <= 99;
            else
              int_duty <= int_duty + 1;
            end if;
          when 1 =>
            if int_duty + 10 > 99 then
              int_duty <= 99;
            else
              int_duty <= int_duty + 10;
            end if;
          when others =>
            int_duty <= int_duty;
        end case;
      elsif decrement = '1' then
        case int_pos is
          when 0 =>
            if int_duty - 1 < 1 then
              int_duty <= 1;
            else
              int_duty <= int_duty - 1;
            end if;
          when 1 =>
            if int_duty - 10 < 1 then
              int_duty <= 1;
            elsif int_duty = 10 then
              int_duty <= 10;
            else
              int_duty <= int_duty - 10;
            end if;
          when others =>
            int_duty <= int_duty;
        end case;
      end if;
    end if;
  end process val_change;

  pos_change : process (left, right, clear) is --! Process to change the position of the duty
  begin
    if en = '1' then
      if clear = '1' then
        int_pos <= 1;
      else
        if left = '1' then
          if int_pos + 1 = 2 then
            int_pos <= 0;
          else
            int_pos <= int_pos + 1;
          end if;
        elsif right = '1' then
          if int_pos - 1 =- 1 then
            int_pos <= 1;
          else
            int_pos <= int_pos - 1;
          end if;
        end if;
      end if;
    end if;
  end process pos_change;

  process (int_pos) is -- Process to change the position of the duty for further processing
  begin
    case int_pos is
      when 0 =>
        pos_duty <= "00001";
      when 1 =>
        pos_duty <= "00010";
      when others =>
        pos_duty <= "00000";
    end case;
  end process;
  out_1  <= std_logic_vector(to_unsigned(int_duty mod 10, 4));
  out_10 <= std_logic_vector(to_unsigned((int_duty / 10) mod 10, 4));

end behavioral;