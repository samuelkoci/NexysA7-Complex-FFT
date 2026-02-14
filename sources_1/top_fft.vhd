library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.complex.all; 

entity top_fft is
    Port ( 
        clk      : in  STD_LOGIC;
        btnC     : in  STD_LOGIC; 
        sw       : in  STD_LOGIC_VECTOR (15 downto 0);
        seg      : out STD_LOGIC_VECTOR (6 downto 0);
        an       : out STD_LOGIC_VECTOR (7 downto 0);
        led      : out STD_LOGIC_VECTOR (15 downto 0)
    );
end top_fft;

architecture Behavioral of top_fft is
    signal din_complex   : complex_x;
    signal dout_fft_sig  : complex_x; 
    signal display_val_32: std_logic_vector(31 downto 0);
begin

    -- Input: Real (sw 7-0), Imaginary (sw 15-8)
    din_complex(0) <= resize(signed(sw(7 downto 0)), length_x);
    din_complex(1) <= resize(signed(sw(15 downto 8)), length_x);

    u_fft: entity work.fft
        port map (
            i_clk    => clk,
            i_rst    => btnC,
            din      => din_complex,
            din_rts  => '1',
            dout     => dout_fft_sig,
            dout_cts => '1'
        );

    -- Combine: [IMAGINARY (Left 4 digits)] & [REAL (Right 4 digits)]
    display_val_32 <= std_logic_vector(dout_fft_sig(1)(15 downto 0)) & 
                      std_logic_vector(dout_fft_sig(0)(15 downto 0));

    u_display: entity work.seven_seg_drive
        port map (
            clk     => clk,
            data_in => display_val_32, 
            seg     => seg,
            an      => an
        );

    led <= sw;
end Behavioral;