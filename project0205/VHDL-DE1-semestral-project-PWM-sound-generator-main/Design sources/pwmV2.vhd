----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2024 02:13:51 AM
-- Design Name: 
-- Module Name: PWM - Behavioral
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
use IEEE.numeric_std.ALL;
use ieee.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWMV2 is
    Port ( clk : in STD_LOGIC;
           rst :  in std_logic;
           sig_in : in STD_LOGIC_VECTOR (7 downto 0);
           freq_in1 : in unsigned(3 downto 0);
           freq_in10 : in unsigned(3 downto 0);
           freq_in100 : in unsigned(3 downto 0);
           freq_in1000 : in unsigned(3 downto 0);
           freq_in10000 : in unsigned(3 downto 0);
           pwm_out : out STD_LOGIC
           );
end PWMV2;

architecture Behavioral of PWMV2 is

constant clock : integer := 1000000;

signal FS : integer := 50000; 
signal freq : integer := 20000;
signal counter : integer := 0;


--signal test : unsigned(7 downto 0) := (others => '0');
signal pwm_clk : STD_LOGIC := '0';
signal pwm_sig : STD_LOGIC := '0';
signal n_clk_samp : integer := 20;
signal n_clk_samp_cnt : integer := 0;
signal duty_high_time : time := 0 us;


begin
freq <= (10000*TO_INTEGER(freq_in10000) + 1000*TO_INTEGER(freq_in1000) + 100*TO_INTEGER(freq_in100) + 10*TO_INTEGER(freq_in10) + TO_INTEGER(freq_in1));

SOUND_SIGNAL_GEN : process(clk) is
begin
    if rising_edge(clk) then
        if rst = '1' then
            counter <= 0;
        else 
            if counter < clock/freq then
                counter <= counter + 1;
            else
                counter <= 0;    
            end if;
        end if;
    end if;
end process;

PWM_CLK1 : process(clk) is
begin
n_clk_samp <= integer(clock/FS);
    if rising_edge(clk) then
        if n_clk_samp_cnt < n_clk_samp/2 - 1 then
            n_clk_samp_cnt <= n_clk_samp_cnt + 1;
        elsif n_clk_samp_cnt = n_clk_samp/2 - 1 then
            pwm_clk <= not(pwm_clk);
            n_clk_samp_cnt <= 0;
        end if;
    end if;
end process;

PWM_signal : process(pwm_clk) is
begin
    if rising_edge(pwm_clk) then
        --test <= counter;
        --duty_high_time <= time(((((counter))*1000)/(clock/freq))* 20 ns);
        pwm_sig <= '1';
        pwm_sig <= '0' after time(((((counter))*1000)/(clock/freq))* 20 ns); 
    end if;
end process;

pwm_out <= pwm_sig;
    
end Behavioral;
