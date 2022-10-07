-- Funçãoo de Próximo Estado

library ieee;
use ieee.std_logic_1164.all;

entity fpe is port(
    ea  : in  std_logic_vector(2 downto 0);  -- Estado atual
    m100, m50, botao : in  std_logic;        -- Moedas e botão (1 real / 50 centavos)
    pe  : out std_logic_vector(2 downto 0)   -- Próximo estado
    );
end entity;

architecture calc of fpe is

begin
    --(~EA2.EA0.M100)+(EA1.EA0.BOTAO)+(EA2.~EA1.~EA0)
    pe(2) <= (not ea(2) and ea(0) and m100) or (ea(1) and ea(0) and botao) or (ea(2) and not ea(1) and not ea(0));

    --(~EA2.~EA1.M50)+(~EA2.EA1.~EA0.~M50)+(EA1.EA0.~BOTAO)+(EA2.~EA1.~EA0.BOTAO)
    pe(1) <= (not ea(2) and not ea(1) and m50) or (not ea(2) and ea(1) and not ea(0) and not m50) or 
             (ea(1) and ea(0) and not botao) or (ea(2) and not ea(1) and not ea(0) and botao);

    --(~EA2.~EA0.M100)+(~EA2.~EA1.EA0.~M100)+(~EA2.EA1.M50.~M100)+(EA1.EA0)
    pe(0) <= (not ea(2) and not ea(0) and m100) or (not ea(2) and not ea(1) and ea(0) and not m100) or
              (not ea(2) and ea(1) and m50 and not m100) or (ea(1) and ea(0));
end;