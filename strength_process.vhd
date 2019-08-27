library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity strength_process is
port(
clk:			in std_logic;
clr:			in std_logic;
blk_w:		in std_logic_vector(2 downto 0);
blk_h:		in std_logic_vector(2 downto 0);
filterType:	in std_logic;
delta:		in signed(7 downto 0);
strength:	out unsigned(1 downto 0)
);

end strength_process;

architecture behavioral of strength_process is
signal	d: signed(7 downto 0);
signal	blk_wh: std_logic_vector(5 downto 0);
signal	temp_strength1, temp_strength2: unsigned(1 downto 0);
signal	temp4,temp8,temp16,temp20,temp32,temp40,temp56,temp64:	signed(7 downto 0);
signal	tam: std_logic_vector(2 downto 0);
begin
temp64 <= d - TO_SIGNED(64,8);
blk_wh <= blk_w & blk_h;
with blk_wh select
    tam <=		"000"        	when B"000_000",  -- 4x4
					"010"				when B"001_001",  -- 8x8
					"110"				when B"010_010",  -- 16x16
					"001"				when B"000_001",  -- 4x8
					"001"				when B"001_000",  -- 8x4
					"111"				when B"001_010",  -- 8x16
					"111"				when B"010_001",  -- 16x8
					"100"				when B"000_010",  -- 4x16
					"100"				when B"010_000",  -- 16x4
					"101"				when others;

					
with filterType select
	strength <=			temp_strength1 when '0',
							temp_strength2 when '1';
end behavioral;