LIBRARY  IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Servo is
  port (
    clk : in std_logic; --horloge 50Mhz, T = 20 ns
    reset : in std_logic; --actif etat haut
    position : in std_logic_vector (7 downto 0); --position sur 8 bits
    commande : out std_logic
  );
end ENTITY;

ARCHITECTURE comportemental of Servo is
  signal tHaut : integer; -- en coups de clock soit 1 <- 20ns
  signal cmpHaut : integer; --compteur etat haut
  signal cmpPeriode : integer; --compteur de periode
  begin
    process(clk, reset, position) begin
      if reset = '1' then
        tHaut <= 25;
        commande <= '0';
        cmpHaut <= 0;
        cmpPeriode <= 0;
      elsif rising_edge(clk) then
        cmpPeriode <= cmpPeriode + 1;
        if cmpHaut < tHaut then
          cmpHaut <= cmpHaut + 1;
          commande <= '1';
        elsif cmpPeriode < 250000 then
          commande <= '0';
        else
          tHaut <= to_integer(unsigned(position))*100000/360 + 12500;
          cmpPeriode <= 0;
          cmpHaut <= 0;
        end if;
      end if;
    end process;
  end ARCHITECTURE;        