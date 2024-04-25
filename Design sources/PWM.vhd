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

entity PWM is
    Port ( clk : in STD_LOGIC;
           --sig_in : in STD_LOGIC_VECTOR (7 downto 0);
           --freq_1 : in unsigned(3 downto 0);
           --freq_10 : in unsigned(3 downto 0);
           --freq_100 : in unsigned(3 downto 0);
           --freq_1000 : in unsigned(3 downto 0);
           --freq_10000 : in unsigned(3 downto 0);
           pwm_out : out STD_LOGIC
           );
end PWM;

architecture Behavioral of PWM is


signal FS : integer := 50000; 
signal freq : integer := 200;

signal sound_sig : unsigned(7 downto 0) := (others => '0');
signal n_clk : integer;    --every nth clock period is counted, n_clk = f_clk/(bit_sound_sig*f_sound), n_clk = 200 -> f_sound = 20
signal x_samp : real; --every xth sample is counted, x_camp = (f_sound*bit_sound_sig)/f_clk, x_samp = 
signal n_clk_cnt : integer := 0;


--signal test : unsigned(7 downto 0) := (others => '0');
signal pwm_clk : STD_LOGIC := '0';
signal pwm_sig : STD_LOGIC := '0';
signal n_clk_samp : integer := 20;
signal n_clk_samp_cnt : integer := 0;
signal duty_high_time : time := 0 us;

begin

SOUND_SIGNAL_GEN : process(clk) is
begin
--freq <= (10000*TO_INTEGER(freq_10000) + 1000*TO_INTEGER(freq_1000) + 100*TO_INTEGER(freq_100) + 10*TO_INTEGER(freq_10) + TO_INTEGER(freq_1)));
    n_clk <= integer(1000000/(256*freq));
    x_samp <= real((freq*256) / 1000000);
    if freq < 200 then
        if rising_edge(clk) then
            if n_clk_cnt < n_clk - 1 then
                n_clk_cnt <= n_clk_cnt +1;
            elsif n_clk_cnt = n_clk - 1 then
                n_clk_cnt <= 0;
                if sound_sig >= (2**8 - 1) then
                    sound_sig <= (others => '0');
                else
                    sound_sig <= sound_sig + 1;  
                end if;
             end if;   
        end if;
    elsif freq > 200 then
        if rising_edge(clk) then
            if n_clk_cnt < n_clk - 1 then
                n_clk_cnt <= n_clk_cnt +1;
            elsif n_clk_cnt = n_clk - 1 then
                n_clk_cnt <= 0;
                if sound_sig >= (2**8 - 1) then
                    sound_sig <= (others => '0');
                else
                    sound_sig <= sound_sig + 1;  
                end if;
             end if;   
        end if;
        
    end if;
end process;

PWM_CLK1 : process(clk) is
begin
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
        --test <= sound_sig;
        duty_high_time <= time(((to_integer(sound_sig))*1000/(2**8))* 20 ns);
        pwm_sig <= '1';
        pwm_sig <= '0' after duty_high_time;
    end if;
end process;

pwm_out <= pwm_sig;
    
end Behavioral;
