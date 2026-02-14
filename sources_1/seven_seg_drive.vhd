library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seven_seg_drive is
    Port ( 
        clk      : in  STD_LOGIC;
        data_in  : in  STD_LOGIC_VECTOR (31 downto 0); -- 8 digits
        seg      : out STD_LOGIC_VECTOR (6 downto 0);
        an       : out STD_LOGIC_VECTOR (7 downto 0)
    );
end seven_seg_drive;

architecture Behavioral of seven_seg_drive is
    signal cnt      : unsigned(19 downto 0) := (others => '0');
    signal digit    : std_logic_vector(3 downto 0);
    signal sel      : std_logic_vector(2 downto 0);
begin
    -- Counter for multiplexing frequency (approx 100Hz per digit)
    process(clk)
    begin
        if rising_edge(clk) then
            cnt <= cnt + 1;
        end if;
    end process;

    sel <= std_logic_vector(cnt(19 downto 17)); -- Use top bits to select digit

    -- 8-to-1 Multiplexer for 32-bit data
    process(sel, data_in)
    begin
        case sel is
            when "000" => digit <= data_in(3 downto 0);   an <= "11111110";
            when "001" => digit <= data_in(7 downto 4);   an <= "11111101";
            when "010" => digit <= data_in(11 downto 8);  an <= "11111011";
            when "011" => digit <= data_in(15 downto 12); an <= "11110111";
            when "100" => digit <= data_in(19 downto 16); an <= "11101111";
            when "101" => digit <= data_in(23 downto 20); an <= "11011111";
            when "110" => digit <= data_in(27 downto 24); an <= "10111111";
            when "111" => digit <= data_in(31 downto 28); an <= "01111111";
            when others => digit <= "0000"; an <= "11111111";
        end case;
    end process;

    -- Hex to 7-segment Decoder (Active Low)
    process(digit)
    begin
        case digit is
            when x"0" => seg <= "1000000"; when x"1" => seg <= "1111001";
            when x"2" => seg <= "0100100"; when x"3" => seg <= "0110000";
            when x"4" => seg <= "0011001"; when x"5" => seg <= "0010010";
            when x"6" => seg <= "0000010"; when x"7" => seg <= "1111000";
            when x"8" => seg <= "0000000"; when x"9" => seg <= "0010000";
            when x"A" => seg <= "0001000"; when x"B" => seg <= "0000011";
            when x"C" => seg <= "1000110"; when x"D" => seg <= "0100001";
            when x"E" => seg <= "0000110"; when x"F" => seg <= "0001110";
            when others => seg <= "1111111";
        end case;
    end process;
end Behavioral;