-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 29.4.2024 08:31:28 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_top_level is
end tb_top_level;

architecture tb of tb_top_level is

    component top_level
        port (SW_MODE   : in std_logic;
              tclk      : in std_logic;
              btn_clr   : in std_logic;
              btn_left  : in std_logic;
              btn_right : in std_logic;
              AUD_PWM   : out std_logic;
              AN        : out std_logic_vector (4 downto 0);
              CA        : out std_logic;
              CB        : out std_logic;
              CC        : out std_logic;
              CD        : out std_logic;
              CE        : out std_logic;
              CF        : out std_logic;
              CG        : out std_logic;
              DP        : out std_logic);
    end component;

    signal SW_MODE   : std_logic;
    signal tclk      : std_logic;
    signal btn_clr   : std_logic;
    signal btn_left  : std_logic;
    signal btn_right : std_logic;
    signal AUD_PWM   : std_logic;
    signal AN        : std_logic_vector (4 downto 0);
    signal CA        : std_logic;
    signal CB        : std_logic;
    signal CC        : std_logic;
    signal CD        : std_logic;
    signal CE        : std_logic;
    signal CF        : std_logic;
    signal CG        : std_logic;
    signal DP        : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : top_level
    port map (SW_MODE   => SW_MODE,
              tclk      => tclk,
              btn_clr   => btn_clr,
              btn_left  => btn_left,
              btn_right => btn_right,
              AUD_PWM   => AUD_PWM,
              AN        => AN,
              CA        => CA,
              CB        => CB,
              CC        => CC,
              CD        => CD,
              CE        => CE,
              CF        => CF,
              CG        => CG,
              DP        => DP);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that tclk is really your main clock signal
    tclk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        SW_MODE <= '0';
        btn_left <= '0';
        btn_right <= '0';

        -- Reset generation
        -- EDIT: Check that btn_clr is really your reset signal
        btn_clr <= '0';
        wait for 10 ns;
        btn_clr <= '1';
        wait for 10 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_top_level of tb_top_level is
    for tb
    end for;
end cfg_tb_top_level;