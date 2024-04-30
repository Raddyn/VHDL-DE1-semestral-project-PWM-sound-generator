library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bin2seg is
    Port ( 
        clear : in std_logic;
        bin   : in std_logic_vector(3 downto 0);
        seg   : out std_logic_vector(6 downto 0)
         );
end bin2seg;

architecture Behavioral of bin2seg is
begin

p_7seg_decoder : process (bin, clear) is
begin

  if (clear = '1') then
    seg <= "1111111";  -- Clear the display
  else

    case bin is
      when x"0" =>     -- x"0" means "0000" in hexadec.
        seg <= "0000001";
      when x"1" =>
        seg <= "1001111";
      when x"2" =>
        seg <= "0010010";
      when x"3" =>
        seg <= "0000110";
      when x"4" =>
        seg <= "1001100";
      when x"5" =>
        seg <= "0100100";
      when x"6" =>
        seg <= "0100000";
      when x"7" =>
        seg <= "0001111";
      when x"8" =>
        seg <= "0000000";
      when x"9" =>
        seg <= "0000100";
      when x"d" =>
        seg <= "1000010";
      when x"F" =>
        seg <= "0111000";
      when x"A" =>
        seg <= "1111111";
      when others =>
        seg <= "0110000";    
    end case;

  end if;    
end process p_7seg_decoder;


end Behavioral;
