library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
entity frequency is
  port
  (
    clear : in std_logic; --! Clear the display
    en    : in std_logic; --! Enable the display
    --        clk : in      std_logic;                    --! Clock signal
    --        freq_bin : out    std_logic_vector(14 downto 0);  --! Frequency of the display
    pos       : out std_logic_vector(4 downto 0); --! Current working position
    left      : in std_logic; --! Move to the left
    right     : in std_logic; --! Move to the right
    increment : in std_logic; --! Increment the frequency
    decrement : in std_logic; --! Decrement the frequency
    out_1     : out std_logic_vector(3 downto 0); --! Output for the next stage
    out_10    : out std_logic_vector(3 downto 0); --! Output for the next stage
    out_100   : out std_logic_vector(3 downto 0); --! Output for the next stage
    out_1000  : out std_logic_vector(3 downto 0); --! Output for the next stage
    out_10000 : out std_logic_vector(3 downto 0) --! Output for the next stage
  );

end entity frequency;

architecture behavioral of frequency is

  signal int_freq : integer := 1000;
  signal int_pos  : integer := 0;

begin

  val_change : process (increment, decrement, clear) is --! Process to change the value of the frequency
  begin
    if en = '0' then
      if clear = '1' then
        int_freq <= 1000;
      else
        if increment = '1' then
          case int_pos is
            when 0 =>
              int_freq <= int_freq + 1;
            when 1 =>
              int_freq <= int_freq + 10;
            when 2 =>
              int_freq <= int_freq + 100;
            when 3 =>
              int_freq <= int_freq + 1000;
            when 4 =>
              int_freq <= int_freq + 10000;
            when others =>
              int_freq <= int_freq;
          end case;
          if int_freq > 20000 then
            int_freq <= 20000;
          end if;
        elsif decrement = '1' then
          case int_pos is
            when 0 =>
              int_freq <= int_freq - 1;
            when 1 =>
              int_freq <= int_freq - 10;
            when 2 =>
              int_freq <= int_freq - 100;
            when 3 =>
              int_freq <= int_freq - 1000;
            when 4 =>
              int_freq <= int_freq - 10000;
            when others =>
              int_freq <= int_freq;
          end case;
          if int_freq < 20 then
            int_freq <= 20;
          end if;
        end if;
      end if;
    end if;
  end process val_change;

  pos_change : process (left, right, clear) is --! Process to change the position of the frequency
  begin
    if en = '0' then --! Only change the position if the display is enabled
      if clear = '1' then
        int_pos <= 2;
      else
        if left = '1' then
          int_pos <= int_pos + 1;
          if int_pos > 4 then
            int_pos <= 0;
          end if;
        elsif right = '1' then
          int_pos <= int_pos - 1;
          if int_pos < 0 then
            int_pos <= 4;
          end if;
        end if;
      end if;
    end if;
  end process pos_change;

  process (int_pos) is
  begin
    case int_pos is
      when 0 =>
        pos <= "00001";
      when 1 =>
        pos <= "00010";
      when 2 =>
        pos <= "00100";
      when 3 =>
        pos <= "01000";
      when 4 =>
        pos <= "10000";
      when others =>
        pos <= "00000";
    end case;
  end process;

  out_1     <= std_logic_vector(to_unsigned(int_freq mod 10, 4));
  out_10    <= std_logic_vector(to_unsigned((int_freq / 10) mod 10, 4));
  out_100   <= std_logic_vector(to_unsigned((int_freq / 100) mod 10, 4));
  out_1000  <= std_logic_vector(to_unsigned((int_freq / 1000) mod 10, 4));
  out_10000 <= std_logic_vector(to_unsigned((int_freq / 10000) mod 10, 4));
end behavioral;