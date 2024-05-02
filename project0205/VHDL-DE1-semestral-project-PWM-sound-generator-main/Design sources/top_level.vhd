
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
    --f_mode_top: in STD_logic;
    --d_mode_top: in std_logic;
    --output: out integer;
    tclk: in std_logic;
    --btn_rst: in std_logic;
    btn_clr : in std_logic;
    btn_left: in std_logic;
    btn_right: in std_logic;
    AUD_PWM: out std_logic;
    
    AN:        out std_logic_vector(7 downto 0);
    CA        : out   std_logic;                     --! Cathod A
    CB        : out   std_logic;                     --! Cathod B
    CC        : out   std_logic;                     --! Cathod C
    CD        : out   std_logic;                     --! Cathod D
    CE        : out   std_logic;                     --! Cathod E
    CF        : out   std_logic;                     --! Cathod F
    CG        : out   std_logic;                     --! Cathod G
    DP        : out   std_logic;                   --! Decimal point 
    --clk_chk: out std_logic;
    JA: in std_logic_vector (1 downto 0);
    JB: out std_logic_vector(6 downto 2)
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
    pos_duty  : out std_logic_vector(4 downto 0); --! Current working position
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
           pos_mulx_freq : out std_logic_vector(7  downto 0);
           seg   : out std_logic_vector(6 downto 0);
           
           out_1_duty     : in std_logic_vector(3 downto 0); 
           out_10_duty    : in std_logic_vector(3 downto 0);
          -- pos_mulx_duty : out std_logic_vector(1  downto 0);      --didn't use this vector and went caveman method and used half of freq vector
           
           sw : in std_logic;
           position_in : in std_logic_vector(4 downto 0)
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
        clk_e : in std_logic;
        data_A : in std_logic;
        data_B : in std_logic;
        Up : out std_logic;
        down : out std_logic
    );
    end component; 
    
    component PWM_module
     port(
        clk: in std_logic;
        freq_in1: in std_logic_vector(3 downto 0);
        freq_in10: in std_logic_vector(3 downto 0);
        freq_in100: in std_logic_vector(3 downto 0);
        freq_in1000: in std_logic_vector(3 downto 0);
        freq_in10000: in std_logic_vector(3 downto 0);
        
        duty_cycle1: in std_logic_vector(3 downto 0);
        duty_cycle10: in std_logic_vector(3 downto 0);
        
        pwm_out: out std_logic
     );
    
    end component;
    
    component mode_selector
     port(
        switch : in  STD_LOGIC; -- Assuming 1 switch
        pos_freq: in std_logic_vector (4 downto 0);
        pos_duty: in std_logic_vector (4 downto 0);
        pos_out: out std_logic_vector (4 downto 0)
     );
     
     end component;
    
    
    component debounce
     port(
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           bouncey : in STD_LOGIC;
           clean : out STD_LOGIC
           );
    end component;
    -- SIGNALS 
	
	signal s_clr: std_logic; --redundant? 
   -- signal audio_out:  STD_LOGIC;
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
    signal s_out_duty1: std_logic_vector (3 downto 0);
    signal s_out_duty10: std_logic_vector (3 downto 0);
    signal s_data_A: std_logic;
    signal s_data_B: std_logic;
    signal s_pos: std_logic_vector (4 downto 0);
    signal s_pos_duty: std_logic_vector (4 downto 0);
    signal s_pos_out: std_logic_vector (4 downto 0);
    signal s_left: std_logic;
    signal s_right: std_logic;

begin

 -- component instantiation
 
    clk1: clock
    generic map (
            N_PERIODS => 1_000_000
        )
        port map (
            cclk   => tclk,
            rst   => btn_clr,
            pulse => clk_en
        );
    enc: encoder 
    port map (
        clk_e => tclk,
        data_A => JA(0),
        data_B => JA(1),
        Up => s_inc,
        Down => s_dec
    
    );
    dbl: debounce
    port map (
        clk => tclk,
        rst => '0',
        en => '1',
        bouncey => btn_left,
        clean => s_left
    );
    
    dbr: debounce
    port map (
        clk => tclk,
        rst => '0',
        en => '1',
        bouncey => btn_right,
        clean => s_right
    );
       
    dbc: debounce
    port map (
        clk => tclk,
        rst => '0',
        en => '1',
        bouncey => btn_clr,
        clean => s_clr
    );   
       
        
	d1: duty
	port map (
	   clear => s_clr,
	   en => mode,
	   left => s_left,
	   right => s_right,
	   increment => s_inc,
	   decrement => s_dec,
	   out_1 => s_out_duty1,
	   out_10 => s_out_duty10,
	   pos_duty => s_pos_duty
	);
	
	f1: frequency 
	port map (
	   clear => s_clr,
	   en => mode,
	   left => s_left,
	   right => s_right,
	   increment => s_inc,
	   decrement => s_dec,
	   out_1 => s_out1,
	   out_10 => s_out10,
	   out_100 => s_out100,
	   out_1000 => s_out1000,
	   out_10000 => s_out10000,
	   pos => s_pos
	);
	    
	    
    DISP: x7seg 
    port map (
       clk => tclk,
       rst => s_clr,
       out_1 => s_out1,
	   out_10 => s_out10,
	   out_100 => s_out100,
	   out_1000 => s_out1000,
	   out_10000 => s_out10000,
	   out_1_duty => s_out_duty1,
	   out_10_duty => s_out_duty10,
       sw => mode,
       position_in => s_pos_out,
       pos_mulx_freq => AN,
       seg(6) => CA,
       seg(5) => CB,
       seg(4) => CC,
       seg(3) => CD,
       seg(2) => CE,
       seg(1) => CF,
       seg(0) => CG

    );
    
    MS: mode_selector
    port map(
        switch => SW_MODE,
        pos_freq => s_pos,
        pos_duty => s_pos_duty,
        pos_out => s_pos_out
    
    );
    
    
    
    PWM: PWM_module
    port map (
        clk => tclk,
        freq_in1 => s_out1,
        freq_in10 => s_out10,
        freq_in100 => s_out100,
        freq_in1000 => s_out1000,
        freq_in10000 => s_out10000,
        duty_cycle1 => s_out_duty1,
        duty_cycle10 => s_out_duty10,    
        
        pwm_out => AUD_PWM
    
    );
    
   
    
    
   -- clk_chk <= tclk;
    DP <= '1';

    JB(2) <= btn_left;
    JB(3) <= btn_right;
    JB(4) <= btn_clr;
    JB(5) <= s_left;
    JB(6) <= s_right;
    process (SW_MODE)
    begin
        if SW_MODE = '0' then
	        mode <= '0';
            
        elsif SW_MODE = '1' then
            mode  <= '1';
        end if;
    end process;

end Behavioral;
