
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
    SW : in STD_LOGIC;  -- mode selector switch
    LED: out STD_LOGIC_VECTOR (15 downto 0)

 
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
    
 
    end component;
    
    signal mode_switch: STD_LOGIC;
    signal rotary_encoder: STD_LOGIC;
    signal audio_out:  STD_LOGIC;
    signal LED_signal: STD_LOGIC_VECTOR (15 downto 0);
    signal frequency_enable: std_logic;
    signal duty_cycle_enable: std_logic;
    signal frequency: integer;
    signal duty_cycle: integer;
    
    
begin
    MS: mode_selector
    port map (
        switch => SW ,
        frequency_mode => frequency_enable,
        duty_cycle_mode => duty_cycle_enable
    
    );
    
    if frequency_mode = '1' then
        --output <= frequency

    else if duty_cycle_mode = '1' then
        --output <= duty_cycle
    
    end if;
    

end Behavioral;
