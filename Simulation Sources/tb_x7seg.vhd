-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 12.4.2024 07:40:21 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_x7seg is
end tb_x7seg;

architecture tb of tb_x7seg is

    component x7seg
        port (x      : in std_logic_vector (15 downto 0);
              clk    : in std_logic;
              clr    : in std_logic;
              a_to_g : out std_logic_vector (6 downto 0);
              an     : out std_logic_vector (3 downto 0);
              dp     : out std_logic);
    end component;

    signal x      : std_logic_vector (15 downto 0);
    signal clk    : std_logic;
    signal clr    : std_logic;
    signal a_to_g : std_logic_vector (6 downto 0);
    signal an     : std_logic_vector (3 downto 0);
    signal dp     : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : x7seg
    port map (x      => x,
              clk    => clk,
              clr    => clr,
              a_to_g => a_to_g,
              an     => an,
              dp     => dp);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        x <= (others => '0');

        -- Reset generation
        -- EDIT: Check that clr is really your reset signal
        clr <= '1';
        wait for 10 ns;
        clr <= '0';
        wait for 10 ns;

        x <= '010011010010';
        wait for 100 * TbPeriod;
        
        an <= '0111';
        wait for 100 * TbPeriod;
        
        an <= '1011';
        wait for 100 * TbPeriod;
        
        an <= '1101';
        wait for 100 * TbPeriod;
        
        an <= '1110';
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_x7seg of tb_x7seg is
    for tb
    end for;
end cfg_tb_x7seg;
