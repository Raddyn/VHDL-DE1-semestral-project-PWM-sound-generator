
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
    --LED: out STD_LOGIC_VECTOR (15 downto 0); --LED functionality cancelled
    f_mode_top: in STD_logic;
    d_mode_top: in std_logic;
    output: out integer;
    tclk: in std_logic;
    btn_rst: in std_logic;
    btn_clr : in std_logic;
    btn_left: in std_logic;
    btn_right: in std_logic
  );
end top_level;

architecture Behavioral of top_level is
 
 -- components declaration
 component duty is 
    port
  (
    clear : in std_logic; --! Clear the display
    en    : in std_logic; --! Enable the display
    --        clk : in      std_logic;                    --! Clock signal
    --        freq_bin : out    std_logic_vector(14 downto 0);  --! duty of the display
    pos_duty  : out std_logic_vector(1 downto 0); --! Current working position
    left      : in std_logic; --! Move to the left
    right     : in std_logic; --! Move to the right
    increment : in std_logic; --! Increment the duty
    decrement : in std_logic; --! Decrement the duty
    out_1     : out std_logic_vector(3 downto 0); --! Output for the next stage
    out_10    : out std_logic_vector(3 downto 0) --! Output for the next stage
  );
    
 end component; 
 
 component frequency is 
    port
  (
    clear : in std_logic; --! Clear the display
    en    : in std_logic; --! Enable the display
    --        clk : in      std_logic;                    --! Clock signal
    --        freq_bin : out    std_logic_vector(14 downto 0);  --! Frequency of the display
    pos       : out std_logic_vector(4 downto 0); --! Current working position
    left      : in std_logic; --! Move to the left
    right     : in std_logic; --! Move to the right
    increment : in std_logic; --! Increment the frequency
    decrement : in std_logic; --! Decrement the frequency
    out_1     : out std_logic_vector(3 downto 0); --! Output for the next stage
    out_10    : out std_logic_vector(3 downto 0); --! Output for the next stage
    out_100   : out std_logic_vector(3 downto 0); --! Output for the next stage
    out_1000  : out std_logic_vector(3 downto 0); --! Output for the next stage
    out_10000 : out std_logic_vector(3 downto 0) --! Output for the next stage
  );
 
 end component; 
 
 component x7seg is
    Port (
           clk : in STD_LOGIC;
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
           pos_mulx_duty : out std_logic_vector(1  downto 0);      --didn't use this vector and went caveman method and used half of freq vector
           
           sw : in std_logic
           );

    end component;
  
  component clock is 
    generic (
        N_PERIODS : integer := 3
    );
    port (
        cclk   : in    std_logic; 
        rst   : in    std_logic; 
        pulse : out   std_logic  
    );
    
    end component;
    
   component encoder is 
    port(
        clk : in std_logic;
        data_A : in std_logic;
        data_B : in std_logic;
        Up : out std_logic;
        down : out std_logic
    );
    end component; 
    
    component pwm_module
     port(
        clk: in std_logic;
        freq_in1: in std_logic_vector(3 downto 0);
        freq_in10: in std_logic_vector(3 downto 0);
        freq_in100: in std_logic_vector(3 downto 0);
        freq_in1000: in std_logic_vector(3 downto 0);
        freq_in10000: in std_logic_vector(3 downto 0);
        
        duty_cycle1: in std_logic_vector(3 downto 0);
        duty_cycle10: in std_logic_vector(3 downto 0);
        
        pwm_out: out std_logic_vector(3 downto 0)
     );
    
    end component;
    
    
    -- SIGNALS 
	
	signal s_clr: std_logic; --redundant? 
    signal audio_out:  STD_LOGIC;
   -- signal LED_signal: STD_LOGIC_VECTOR (15 downto 0);
    signal clk_en: std_logic;
    signal mode: std_logic;
    signal s_inc: std_logic;
    signal s_dec: std_logic;
    signal s_out1: std_logic_vector (3 downto 0);
    signal s_out10: std_logic_vector (3 downto 0);
    signal s_out100: std_logic_vector (3 downto 0);
    signal s_out1000: std_logic_vector (3 downto 0);
    signal s_out10000: std_logic_vector (3 downto 0);
    signal s_data_A: std_logic;
    signal s_data_B: std_logic;
begin
    clk1: clock
    generic map (
            N_PERIODS => 1_000_000
        )
        port map (
            cclk   => tclk,
            rst   => btn_rst,
            pulse => clk_en
        );
    enc: encoder 
    port map (
        clk => tclk,
        data_A => s_data_A,
        data_B => s_data_B,
        Up => s_inc,
        Down => s_dec
    
    );
        
	d1: duty
	port map (
	   clear => btn_clr,
	   en => mode,
	   left => btn_left,
	   right => btn_right,
	   increment => s_inc,
	   decrement => s_dec,
	   out_1 => s_out1,
	   out_10 => s_out10
	);
	
	f1: frequency 
	port map (
	   clear => btn_clr,
	   en => mode,
	   left => btn_left,
	   right => btn_right,
	   increment => s_inc,
	   decrement => s_dec,
	   out_1 => s_out1,
	   out_10 => s_out10,
	   out_100 => s_out100,
	   out_1000 => s_out1000,
	   out_10000 => s_out10000
	);
	    
	    
    DISP: x7seg -- fix in top_x7seg
    port map (
       clk => tclk,
       rst => btn_rst,
       out_1 => s_out1,
	   out_10 => s_out10,
	   out_100 => s_out100,
	   out_1000 => s_out1000,
	   out_10000 => s_out10000,
	   out_1_duty => s_out1,
	   out_10_duty => s_out10,
       sw => mode
   
    );
    process (SW_MODE)
    begin
        if SW_MODE = '0' then
	        mode <= '0';
            
        elsif SW_MODE = '1' then
            mode  <= '1';
        end if;
    end process;

end Behavioral;
