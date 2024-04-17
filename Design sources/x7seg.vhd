----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2024 11:21:10
-- Design Name: 
-- Module Name: x7seg - Behavioral
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

entity x7seg is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           out_1 : in std_logic_vector(3 downto 0);
           out_10 : in std_logic_vector(3 downto 0);
           out_100 : in std_logic_vector(3 downto 0);
           out_1000 : in std_logic_vector(3 downto 0);
           out_10000 : in std_logic_vector(3 downto 0);
           pos_mulx_freq : out std_logic_vector(4  downto 0);
           seg   : out std_logic_vector(6 downto 0);
           
           out_1_duty     : in std_logic_vector(3 downto 0); 
           out_10_duty    : in std_logic_vector(3 downto 0);
           pos_mulx_duty : out std_logic_vector(1  downto 0);
           
           sw : in std_logic
           );
end x7seg;

architecture Behavioral of x7seg is
    component bin2seg is
        port(
            clear : in std_logic;
            bin : in std_logic_vector(3downto 0);
            seg : out std_logic_vector(6 downto 0)
            );
    end component;
   
    component counter is
        port(
            clk : in std_logic;
            rst : in std_logic;
            en : in std_logic;
            count: out std_logic_vector(3 downto 0)
            );
    end component;
    
    component clock_enable is
    generic(
        N_PERIODS : integer
        );
    port(
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        pulse : out STD_LOGIC
    );
    end component;

    signal per_mulx: std_logic;
    signal position: std_logic_vector(3 downto 0);
    signal seg_data: std_logic_vector(3 downto 0);
begin

    out2seg : component bin2seg
        port map(
            clear => rst,
            bin => seg_data,
            seg => seg
            );

    period : component clock_enable
        generic map(
            N_PERIODS => 300000
            )
        port map(
            clk => clk,
            rst => rst,
            pulse => per_mulx
            );

    switch_seg : component counter
        port map(
            clk => clk,
            rst => rst,
            en => per_mulx,
            count => position
            );
            


    process (clk) is
    begin
        
        if (rising_edge(clk)) then
            if (rst = '1') then
                seg_data <= "1111111";
            elsif (sw = '0') then
                case position is
                    when "001" =>
                        seg_data <= out_1;
                        pos_mulx_freq <= "11110";
                    
                    when "010" =>
                        seg_data <= out_10;
                        pos_mulx_freq <= "11101";
                    
                    when "100" =>
                        seg_data <= out_100;
                        pos_mulx_freq <= "11011";
                    
                    when "101" =>
                        seg_data <= out_1000;
                        pos_mulx_freq <= "10111";
                    
                    when "110" =>
                        seg_data <= out_10000;
                        pos_mulx_freq <= "01110";
                    
                end case;
                    
            else
                case position is
                    when "001" =>
                        seg_data <= out_1_duty;
                        pos_mulx_freq <= "11110";
                    
                    when "010" =>
                        seg_data <= out_10_duty;
                        pos_mulx_freq <= "11101";
                    
                    when "100" =>
                        seg_data <= "1111111";
                        pos_mulx_freq <= "11011";
                    
                    when "101" =>
                        seg_data <= "1111111";
                        pos_mulx_freq <= "10111";
                    
                    when "110" =>
                        seg_data <= "1111111";
                        pos_mulx_freq <= "01110";
                end case;
            end if;
        end if;
    end process;


end Behavioral;
