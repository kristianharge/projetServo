Library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

-- ---------------------------------------
Entity FDIV is
-- ---------------------------------------
  Generic (  Fclock  : positive := 50E6); -- System Clock Freq in Hertz
      Port (  Clk     : In    std_logic;
              Rst     : In    std_logic;
              Tick : Out   std_logic  );
end entity FDIV;

-- ---------------------------------------
    Architecture RTL of FDIV is
-- ---------------------------------------

constant Divisor : positive := Fclock / 90000; --on divise la frequence par la frequence cherchee
signal Count     : integer range 0 to Divisor-1;

-----
Begin
-----

process (Clk,Rst)
begin
  if Rst='1' then
    Count <= 0;
    Tick <= '0';
  elsif rising_edge (Clk) then
    Tick <= '0';
    if Count = 0  then
      Tick <= '1';
      Count <= Divisor-1;
    else
      Count <= Count - 1;
    end if;
  end if;
end process;

end architecture RTL;

