----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2024 11:49:27 AM
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port (
    clk: in std_logic;
    AUD_PWM: out std_logic );
    
end top;

architecture Behavioral of top is

component pwm_module is 
    port (
        clk: in std_logic;
        pwm_out: out std_logic
    
    );
end component;
begin

    pwm1: pwm_module
      port map(
        clk => clk,
        pwm_out => AUD_PWM
      );

end Behavioral;
