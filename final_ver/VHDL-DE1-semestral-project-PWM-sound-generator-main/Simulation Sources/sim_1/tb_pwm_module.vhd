-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 29.4.2024 07:52:51 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_PWM_module is
end tb_PWM_module;

architecture tb of tb_PWM_module is

    component PWM_module
        port (clk          : in std_logic;
              freq_in1     : in std_logic_vector (3 downto 0);
              freq_in10    : in std_logic_vector (3 downto 0);
              freq_in100   : in std_logic_vector (3 downto 0);
              freq_in1000  : in std_logic_vector (3 downto 0);
              freq_in10000 : in std_logic_vector (3 downto 0);
              duty_cycle1  : in std_logic_vector (3 downto 0);
              duty_cycle10 : in std_logic_vector (3 downto 0);
              pwm_out      : out std_logic);
    end component;

    signal clk          : std_logic;
    signal freq_in1     : std_logic_vector (3 downto 0);
    signal freq_in10    : std_logic_vector (3 downto 0);
    signal freq_in100   : std_logic_vector (3 downto 0);
    signal freq_in1000  : std_logic_vector (3 downto 0);
    signal freq_in10000 : std_logic_vector (3 downto 0);
    signal duty_cycle1  : std_logic_vector (3 downto 0);
    signal duty_cycle10 : std_logic_vector (3 downto 0);
    signal pwm_out      : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : PWM_module
    port map (clk          => clk,
              freq_in1     => freq_in1,
              freq_in10    => freq_in10,
              freq_in100   => freq_in100,
              freq_in1000  => freq_in1000,
              freq_in10000 => freq_in10000,
              duty_cycle1  => duty_cycle1,
              duty_cycle10 => duty_cycle10,
              pwm_out      => pwm_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        freq_in1 <= "0000";
        freq_in10 <= "0000";
        freq_in100 <= "0000";
        freq_in1000 <= "0001";
        freq_in10000 <= "0000";
        duty_cycle1 <= "0000";
        duty_cycle10 <= "0101";

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_PWM_module of tb_PWM_module is
    for tb
    end for;
end cfg_tb_PWM_module;