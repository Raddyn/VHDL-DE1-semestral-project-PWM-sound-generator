-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 12.4.2024 08:23:05 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_x7seg_top is
end tb_x7seg_top;

architecture tb of tb_x7seg_top is

    component x7seg_top
        port (mclk   : in std_logic;
              x      : in std_logic_vector(15 downto 0);
              btn    : in std_logic;
              a_to_g : out std_logic_vector (6 downto 0);
              an     : out std_logic_vector (3 downto 0);
              dp     : out std_logic);
    end component;

    signal mclk   : std_logic;
    signal x    : std_logic_vector (15 downto 0);
    signal btn    : std_logic;
    signal a_to_g : std_logic_vector (6 downto 0);
    signal an     : std_logic_vector (3 downto 0);
    signal dp     : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : x7seg_top
    port map (mclk   => mclk,
              x      => x,
              btn    => btn,
              a_to_g => a_to_g,
              an     => an,
              dp     => dp);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that mclk is really your main clock signal
    mclk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        

        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        an <= "1011";
        btn <= '1';
        wait for 10 ns;
        btn <= '0';
        wait for 10 ns;
        wait for 10 ns;
        x <= "0001001000110100";
        wait for 100 * TbPeriod;
        
        an <= "1111";
        wait for 100 * TbPeriod;
        
        an <= "0111";
        wait for 100 * TbPeriod;
        
        an <= "1011";
        wait for 100 * TbPeriod;
        
        an <= "1101";
        wait for 100 * TbPeriod;
        
        an <= "1110";
        wait for 100 * TbPeriod;


        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_x7seg_top of tb_x7seg_top is
    for tb
    end for;
end cfg_tb_x7seg_top;
