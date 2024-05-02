library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_encoder is
end tb_encoder;

architecture Behavioral of tb_encoder is

    -- Component Declaration
    component encoder is
        port(
            clk_e : in std_logic;
            data_A : in std_logic;
            data_B : in std_logic;
            Up : out std_logic;
            down : out std_logic
        );
    end component;

    -- Signal Declarations
    signal clk_tb : std_logic := '0';
    signal data_A_tb : std_logic := '0';
    signal data_B_tb : std_logic := '0';
    signal Up_tb : std_logic;
    signal down_tb : std_logic;

begin

    -- Instantiate the encoder
    uut: encoder
        port map(
            clk_e => clk_tb,
            data_A => data_A_tb,
            data_B => data_B_tb,
            Up => Up_tb,
            down => down_tb
        );

    -- Clock process
    clk_process: process
    begin
        while now < 1000 ns loop
            clk_tb <= '0';
            wait for 1 ns;
            clk_tb <= '1';
            wait for 1 ns;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Add your test stimulus here
        -- Example:
        data_A_tb <= not '0';
        data_B_tb <= not '0';
        wait for 50 ns;
        data_A_tb <= not '1';
        data_B_tb <= not '0';
        wait for 50 ns;
        data_A_tb <= not '1';
        data_B_tb <= not '1';
        wait for 50 ns;
        data_A_tb <= not '0';
        data_B_tb <= not '1';
        wait for 50 ns;
        data_A_tb <= not '0';
        data_B_tb <= not '0';
        wait for 50 ns;
        data_A_tb <= not '0';
        data_B_tb <= not '1';
        wait for 50 ns;
        data_A_tb <= not '1';
        data_B_tb <= not '1';
        wait for 50 ns;
        data_A_tb <= not '1';
        data_B_tb <= not '0';
        wait for 50 ns;
        data_A_tb <= not '0';
        data_B_tb <= not '0';


        wait;
    end process;

end Behavioral;
