----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:22:27 08/12/2016 
-- Design Name: 
-- Module Name:    cot_mainCode - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cot_mainCode is port
(
clk, reset : in std_logic;
phase : in std_logic_vector(7 downto 0 );
cot : out std_logic_vector(7 downto 0);
error : out std_logic
);
end cot_mainCode;

architecture Behavioral of cot_mainCode is

component Cos_mainCode is port (
clk , reset: in  STD_LOGIC;
           phase : in  STD_LOGIC_VECTOR (7 downto 0);
           cos : out  STD_LOGIC_VECTOR (7 downto 0);
			  error : out STD_LOGIC
			  );
end component;

component Sin_mainCode is port(
 clk , reset: in  STD_LOGIC;
           phase : in  STD_LOGIC_VECTOR (7 downto 0);
           sin : out  STD_LOGIC_VECTOR (7 downto 0);
			  error : out STD_LOGIC
			  );
end component;

component divider_mainCode is port
(num1 , num2 : in std_logic_vector(7 downto 0);
clk , reset : in std_logic;
result : out std_logic_vector(7 downto 0);
error : out std_logic
);
end component;

signal  cos , sin , division : std_logic_vector(7 downto 0);
signal cosError , sinError, dividerError : std_logic;

begin
cosComponentCot : Cos_mainCode port map(clk, reset ,phase , cos ,cosError);
sinComponentCot : Sin_mainCode port map(clk , reset, phase , sin , sinError);
dividerComponentCot : divider_mainCode port map(cos,sin, clk, reset, division, dividerError);
error<= cosError or sinError or dividerError ; 
cot <= division;


end Behavioral;

