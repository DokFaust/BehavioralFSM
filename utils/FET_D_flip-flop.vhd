---------------------------------------------------------------
-- D flip-flop: FET D flip-flop with asynchronous preset. The
-- preset input takes precedence over the synchronous input.
--
-- Required signals:
---------------------------------------------------------------
-- CLK,D,S: in std_logic;
-- Q:       out std_logic;
---------------------------------------------------------------
process(CLK, S)
begin
    if(S = '0') then
        Q <= '1';
    elsif (falling_edge(CLK)) then
        Q <= D;
    end if;
end process;
