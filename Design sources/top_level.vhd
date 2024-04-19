
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
 Port (
    SW_MODE : in STD_LOGIC;  -- mode selector switch
    LED: out STD_LOGIC_VECTOR (15 downto 0);
    f_mode_top: in STD_logic;
    d_mode_top: in std_logic;
    output: out integer;
    tclk: in std_logic;
    btn_rst: in std_logic
  );
end top_level;

architecture Behavioral of top_level is

component mode_selector is
    Port ( 
        switch : in  STD_LOGIC; -- Assuming 1 switch
        frequency_mode : out STD_LOGIC;
        duty_cycle_mode : out STD_LOGIC   
           );
   
    end component;
    
 component top_x7seg is   --tbd, when full integer number => 8 display output functionality  is achieved
    Port (
        	mclk: in std_logic;
		btn: in std_logic_vector(3 downto 3);
		a_to_g: out std_logic_vector(6 downto 0);
		an: out std_logic_vector(3 downto 0);
		dp: out std_logic
		);
 
    end component;
  
  component clock is 
    generic (
        N_PERIODS : integer := 3
    );
    port (
        clk   : in    std_logic; 
        rst   : in    std_logic; 
        pulse : out   std_logic  
    );
    
    end component;
  
  
    signal mode_switch: STD_LOGIC;
    signal rotary_encoder: STD_LOGIC;
    signal audio_out:  STD_LOGIC;
    signal LED_signal: STD_LOGIC_VECTOR (15 downto 0);
    signal frequency_enable: std_logic;
    signal duty_cycle_enable: std_logic;
    signal frequency: integer;
    signal duty_cycle: integer;
    signal to_disp: integer;
    signal clk_en: std_logic;
    
begin
    clk1: clock
    generic map (
            N_PERIODS => 1_000_000
        )
        port map (
            clk   => tclk,
            rst   => btn_rst,
            pulse => clk_en
        );

    MS: mode_selector
    port map (
        switch => SW_MODE ,
        frequency_mode => frequency_enable,
        duty_cycle_mode => duty_cycle_enable
    );
    DISP: top_x7seg -- fix in top_x7seg
    port map (
        mclk => tclk,
	btn_rst => btn,
        
    
    );
    process (f_mode_top, d_mode_top)
    begin
        if f_mode_top = '1' then
            output <= frequency;
        elsif d_mode_top = '1' then
            output <= duty_cycle;
        end if;
    end process;

end Behavioral;
