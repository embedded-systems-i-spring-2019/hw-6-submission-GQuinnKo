----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2019 01:09:23 PM
-- Design Name: 
-- Module Name: ex11_13 - Behavioral
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

entity ex11_13 is
  Port ( CLK, X1, X2 : in std_logic;
       CS, RD : out std_logic;
       Y : out std_logic_vector(2 downto 0));
end ex11_13;

architecture Behavioral of ex11_13 is

type state_type is (ST0,ST1,ST2); --ST0,ST1,ST2 is a,b,c respectively
signal PS,NS : state_type;

begin

process(clk, NS)
begin
if (rising_edge(CLK)) then
    PS <= NS;
end if;
end process;

process(PS, X1, X2)
begin

case PS is
    when  ST0 =>
        if( X1 = '1') then 
            NS <= ST2;
            CS <= '1';
            RD <= '0';
        else    
            NS <= ST1;
            CS <= '0';
            RD <= '1';
        end if;
            
    when ST1 =>
        NS <= ST2;
        CS <= '1';
        RD <= '1';
    
    when ST2 =>
        if( X2 = '1') then 
        NS <= ST2;
        CS <= '0';
        RD <= '1';
    else    
        NS <= ST0;
        CS <= '0';
        RD <= '0';
    end if;

    when others => 
        NS <= ST0;
        CS <= '0';
        RD <= '0';
    end case;
end process;

with PS select Y <= 
      "001" when ST0,
      "010" when ST1,
      "100" when ST2,
      "001" when others;
      


end Behavioral;
