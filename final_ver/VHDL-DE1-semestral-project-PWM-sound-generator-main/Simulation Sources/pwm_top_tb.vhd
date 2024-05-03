
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity pwm_top_tb is
end entity;


architecture Behavioral of pwm_top_tb is    
    
    component PWMV2 is
        Port ( clk : in STD_LOGIC;
               rst : in std_logic;
               --sig_in : in STD_LOGIC_VECTOR (7 downto 0);
               pwm_out : out std_logic
               );
    end component;
   
    
    component clock_enable is
        generic (
                N_PERIODS : integer := 3
                );
        port (
                clk   : in    std_logic; 
                rst   : in    std_logic; 
                pulse : out   std_logic  
                );
    end component;
    
 signal clk: STD_LOGIC;
 signal rst: std_logic;
 signal clk_pulse: STD_LOGIC;
 signal pwm_sig: STD_LOGIC;
 
constant TbPeriod : time := 1 us; -- EDIT Put right period here
signal TbClock : std_logic := '0';
signal TbSimEnded : std_logic := '0';
    
 begin
    clkk: clock_enable
    generic map (
            N_PERIODS => 1_000_000
        )
        port map (
            clk   => clk,
            rst   => rst,
            pulse => clk_pulse
        );
    
    PWM1: PWMV2
    port map (
            clk   => clk,
            rst   => rst,
            pwm_out => pwm_sig
        );
     
     
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

 end Behavioral;
 
