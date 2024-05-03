library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity x7seg is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           out_1 : in std_logic_vector(3 downto 0);
           out_10 : in std_logic_vector(3 downto 0);
           out_100 : in std_logic_vector(3 downto 0);
           out_1000 : in std_logic_vector(3 downto 0);
           out_10000 : in std_logic_vector(3 downto 0);
           pos_mulx_freq : out std_logic_vector(7  downto 0);
           seg   : out std_logic_vector(6 downto 0);
           
           out_1_duty     : in std_logic_vector(3 downto 0); 
           out_10_duty    : in std_logic_vector(3 downto 0);
           
           sw : in std_logic;
           position_in : in std_logic_vector(4 downto 0)           
         
           );
end x7seg;

architecture Behavioral of x7seg is
    component bin2seg is
        port(
            clear : in std_logic;
            bin : in std_logic_vector(3 downto 0);
            seg : out std_logic_vector(6 downto 0)
            );
    end component;
   
    component counter is
        generic(
        N_COUNTS : integer
        );
        port(
            clk : in std_logic;
            rst : in std_logic;
            en : in std_logic;
            count: out std_logic_vector(2 downto 0)
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
    signal per_mulx_pos: std_logic;
    signal position_period: std_logic_vector(2 downto 0);    
    signal position: std_logic_vector(2 downto 0);
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
            N_PERIODS => 1_666_667        -- setings for 60 Hz
            )
        port map(
            clk => clk,
            rst => rst,
            pulse => per_mulx
            );
           
    period_pos : component clock_enable
        generic map(
            N_PERIODS => 333_333_334            -- settings for indicating position
            )
        port map(
            clk => clk,
            rst => rst,
            pulse => per_mulx_pos
            );
            
    switch_seg : component counter
       generic map(
            N_COUNTS => 6
            )
        port map(
            clk => clk,
            rst => rst,
            en => per_mulx,
            count => position
            );
            
    switch_seg_position : component counter
       generic map(
            N_COUNTS => 5
            )
        port map(
            clk => clk,
            rst => rst,
            en => per_mulx_pos,
            count => position_period
            );                        


    process (clk) is
    begin
          
        if (rising_edge(clk)) then
            if (rst = '1') then
                seg_data <= "0000";
            elsif (sw = '0') then

            
                case position is
                    when "000" =>
                        if (position_in = "00001") then                 
                           if(position_period < "010") then             
                            seg_data <= x"A";
                            pos_mulx_freq <= "11111110";
                           else 
                            seg_data <= out_1;
                            pos_mulx_freq <= "11111110";
                            end if;
                            
                        else
                            seg_data <= out_1;
                            pos_mulx_freq <= "11111110";
                        end if;
                    
                    when "001" =>
                        if (position_in = "00010") then                 
                           if(position_period < "010") then
                            seg_data <= x"A";
                            pos_mulx_freq <= "11111101";
                           else
                            seg_data <= out_10;
                            pos_mulx_freq <= "11111101";
                           end if;
                         else
                            seg_data <= out_10;
                            pos_mulx_freq <= "11111101";
                        end if;
                    
                    when "010" =>
                        if (position_in = "00100") then                 
                           if(position_period < "010") then
                            seg_data <= x"A";
                            pos_mulx_freq <= "11111011";
                           else
                            seg_data <= out_100;
                            pos_mulx_freq <= "11111011";
                           end if;
                         else
                            seg_data <= out_100;
                            pos_mulx_freq <= "11111011";
                        end if;
                    
                    when "011" =>
                        if (position_in = "01000") then                 
                           if(position_period < "010") then
                            seg_data <= x"A";
                            pos_mulx_freq <= "11110111";
                           else
                            seg_data <= out_1000;
                            pos_mulx_freq <= "11110111";
                           end if;
                         else
                            seg_data <= out_1000;
                            pos_mulx_freq <= "11110111";
                        end if;
                    
                    when "100" =>
                        if (position_in = "10000") then                 
                           if(position_period < "010") then
                            seg_data <= x"A";
                            pos_mulx_freq <= "11101111";
                           else
                            seg_data <= out_10000;
                            pos_mulx_freq <= "11101111";
                           end if;
                         else
                            seg_data <= out_10000;
                            pos_mulx_freq <= "11101111";
                        end if;
                        
                    when "101" =>
                            seg_data <= x"F";
                            pos_mulx_freq <= "01111111";
                        
                        
                    when others =>
                        seg_data<= x"E";
                        pos_mulx_freq <= "11111110";
                    
                end case;
                    
            else
       
                case position is
                    when "000" =>
                        if (position_in = "00001") then                 
                           if(position_period < "010") then
                            seg_data <= x"A";
                            pos_mulx_freq <= "11111110";
                           else
                            seg_data <= out_1_duty;
                            pos_mulx_freq <= "11111110";
                           end if;
                         else
                            seg_data <= out_1_duty;
                            pos_mulx_freq <= "11111110";
                        end if;
                    
                    when "001" =>
                        if (position_in = "00010") then                 
                           if(position_period < "010") then
                            seg_data <= x"A";
                            pos_mulx_freq <= "11111101";
                           else
                            seg_data <= out_10_duty;
                            pos_mulx_freq <= "11111101";
                           end if;
                         else
                            seg_data <= out_10_duty;
                            pos_mulx_freq <= "11111101";
                        end if;
                        
                    when "010" =>
                        
                            seg_data <= x"d";
                            pos_mulx_freq <= "01111111";
                   
                   when "011" =>
                            pos_mulx_freq <= "11111111";
                   when "100" =>
                            pos_mulx_freq <= "11111111";
                   
                   when "101" =>
                            pos_mulx_freq <= "11111111";
                        
                     
                    
                    when others =>
                        seg_data <= x"E";
                        pos_mulx_freq <= "11111110";
                        
                    
                    
                end case;
            end if;
        end if;
    end process;


end Behavioral;
