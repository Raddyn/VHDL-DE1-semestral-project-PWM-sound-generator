library IEEE;

use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

-- Define ports of the encoder module
entity encoder is
  port
  (
    clk_e  : in std_logic; -- Clock signal
    data_A : in std_logic; -- Input signal A
    data_B : in std_logic; -- Input signal B
    Up     : out std_logic; -- Up signal
    down   : out std_logic -- Down signal
  );
end encoder;
-- Define the architecture of the encoder module
architecture Behavioral of encoder is
  -- Add the debounce component
  component debounce is
    port
    (
      clk     : in std_logic; -- Clock signal
      rst     : in std_logic; -- Reset signal
      en      : in std_logic; -- Enable signal
      bouncey : in std_logic; -- Input signal
      clean   : out std_logic -- Output signal
    );
  end component;
  signal count          : std_logic_vector(1 downto 0) := "11";
  -- signal count_int      : integer                      := 0;
  signal previous_count : std_logic_vector(1 downto 0) := "11";
  -- signal inc            : std_logic                    := '1';
  -- signal dec            : std_logic                    := '1';
  -- Instantiate the debounce component
begin
  bnc1 : debounce port map
  (
    clk     => clk_e,
    rst     => '0',
    en      => '1',
    bouncey => data_A,
    clean   => count(0)
  );
  bnc2 : debounce port
  map
  (
  clk     => clk_e,
  rst     => '0',
  en      => '1',
  bouncey => data_B,
  clean   => count(1)
  );
  -- Convert the count to an integer
  -- int_det : process (clk_e)
  -- begin
  --   case count is -- Convert the count to an integer
  --     when "11" =>
  --       count_int <= 0;
  --     when "10" =>
  --       count_int <= 1;
  --     when "00" =>
  --       count_int <= 2;
  --     when "01" =>
  --       count_int <= 3;
  --     when others =>
  --       count_int <= 0;
  --   end case;
  -- end process;
  -- Detect the direction of the encoder
  direction : process (count)
  begin
    if count = "11" and previous_count = "01" then
      up <= '0';
      down <= '1';
    elsif count = "11" and previous_count = "10" then
      up <= '1';
      down <= '0';
    else
      up <= '1';
      down <= '1';
    end if;
end process;

prev_change : process (clk_e)
begin
  previous_count <= count;
end process;
end Behavioral;