--Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 19.4.2024 08:37:34 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_duty is
end tb_duty;

architecture tb of tb_duty is

    component duty
        port (clear     : in std_logic;
              en        : in std_logic;
              pos       : out std_logic_vector (4 downto 0);
              left      : in std_logic;
              right     : in std_logic;
              increment : in std_logic;
              decrement : in std_logic;
              out_1     : out std_logic_vector (3 downto 0);
              out_10    : out std_logic_vector (3 downto 0)
        );
    end component;

    signal clear     : std_logic;
    signal en        : std_logic;
    signal pos       : std_logic_vector (4 downto 0);
    signal left      : std_logic;
    signal right     : std_logic;
    signal increment : std_logic;
    signal decrement : std_logic;
    signal out_1     : std_logic_vector (3 downto 0);
    signal out_10    : std_logic_vector (3 downto 0);
begin

    
    dut : duty
    port map (clear     => clear,
              en        => en,
              pos       => pos,
              left      => left,
              right     => right,
              increment => increment,
              decrement => decrement,
              out_1     => out_1,
              out_10    => out_10
);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        en <= '0';
        left <= '0';
        right <= '0';
        increment <= '0';
        decrement <= '0';
        wait for 10 ns;
        en <= '1';

        -- Reset generation
        -- EDIT: Check that clear is really your reset signal
        clear <= '1';
        wait for 10 ns;
        clear <= '0';
        wait for 10 ns;

        -- EDIT Add stimuli here
       left <= '1';
         wait for 10 ns;    
        left <= '0';
        wait for 10 ns;
        for i in 0 to 50 loop
            increment <= '1';
            wait for 10 ns;
            increment <= '0';
            wait for 10 ns;
        end loop;
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_duty of tb_duty is
    for tb
    end for;
end cfg_tb_duty;