library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity PWM_module is
  port
  (
    clk          : in std_logic;
    freq_in1     : in std_logic_vector(3 downto 0);
    freq_in10    : in std_logic_vector(3 downto 0);
    freq_in100   : in std_logic_vector(3 downto 0);
    freq_in1000  : in std_logic_vector(3 downto 0);
    freq_in10000 : in std_logic_vector(3 downto 0);
    duty_cycle1  : in std_logic_vector(3 downto 0);
    duty_cycle10 : in std_logic_vector(3 downto 0);
    pwm_out      : out std_logic
  );
end PWM_module;

architecture behavioral of PWM_module is
  signal clock      : integer := 1000000;
  signal counter    : integer := 0;
  signal freq       : integer := 0;
  signal duty_cycle : integer := 0;

begin
  process (clk)
  begin
    if rising_edge(clk) then
      if counter < clock/freq then
        if counter < (duty_cycle * clock)/(100 * freq) then
          pwm_out <= '1';
          counter <= counter + 1;
        else
          pwm_out <= '0';
          counter <= counter + 1;
        end if;
      else
        counter <= 0;
      end if;
    end if;
  end process;
  freq       <= (to_integer(unsigned(freq_in10000)) * 10000 + to_integer(unsigned(freq_in1000)) * 1000 + to_integer(unsigned(freq_in100)) * 100 + to_integer(unsigned(freq_in10)) * 10 + to_integer(unsigned(freq_in1)));
  duty_cycle <= (to_integer(unsigned(duty_cycle10)) * 10 + to_integer(unsigned(duty_cycle1)));

end architecture;