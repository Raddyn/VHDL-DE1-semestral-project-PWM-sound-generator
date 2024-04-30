-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 30.4.2024 15:31:38 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_x7seg is
end tb_x7seg;

architecture tb of tb_x7seg is

    component x7seg
        port (clk           : in std_logic;
              rst           : in std_logic;
              out_1         : in std_logic_vector (3 downto 0);
              out_10        : in std_logic_vector (3 downto 0);
              out_100       : in std_logic_vector (3 downto 0);
              out_1000      : in std_logic_vector (3 downto 0);
              out_10000     : in std_logic_vector (3 downto 0);
              pos_mulx_freq : out std_logic_vector (7  downto 0);
              seg           : out std_logic_vector (6 downto 0);
              out_1_duty    : in std_logic_vector (3 downto 0);
              out_10_duty   : in std_logic_vector (3 downto 0);
              sw            : in std_logic;
              position_in   : in std_logic_vector (4 downto 0));
    end component;

    signal clk           : std_logic;
    signal rst           : std_logic;
    signal out_1         : std_logic_vector (3 downto 0);
    signal out_10        : std_logic_vector (3 downto 0);
    signal out_100       : std_logic_vector (3 downto 0);
    signal out_1000      : std_logic_vector (3 downto 0);
    signal out_10000     : std_logic_vector (3 downto 0);
    signal pos_mulx_freq : std_logic_vector (7  downto 0);
    signal seg           : std_logic_vector (6 downto 0);
    signal out_1_duty    : std_logic_vector (3 downto 0);
    signal out_10_duty   : std_logic_vector (3 downto 0);
    signal sw            : std_logic;
    signal position_in   : std_logic_vector (4 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : x7seg
    port map (clk           => clk,
              rst           => rst,
              out_1         => out_1,
              out_10        => out_10,
              out_100       => out_100,
              out_1000      => out_1000,
              out_10000     => out_10000,
              pos_mulx_freq => pos_mulx_freq,
              seg           => seg,
              out_1_duty    => out_1_duty,
              out_10_duty   => out_10_duty,
              sw            => sw,
              position_in   => position_in);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        out_1 <= x"5";
        out_10 <= x"4";
        out_100 <= x"3";
        out_1000 <= x"2";
        out_10000 <= x"1";
        out_1_duty <= x"0";
        out_10_duty <= x"5";
        sw <= '0';
        position_in <= "00001";

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        --wait for 100 * TbPeriod;
        position_in <= "00100";
        wait for 1936 ns;
        sw <= '1';
        position_in <= "00001";
        wait for 1000 ns;
        out_10_duty <= x"1";
        
        -- Stop the clock and hence terminate the simulation
       -- TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_x7seg of tb_x7seg is
    for tb
    end for;
end cfg_tb_x7seg;
