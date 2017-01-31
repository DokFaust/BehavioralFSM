--------------------------------------------------
-- D Flip-flop: RET D flip-flop with single output
--
-- Required signals:
--------------------------------------------------
-- CLK, D: in std_logic;
-- Q:      out std_logic;
--------------------------------------------------
process (CLK)
begin
    if (rising_edge(CLK)) then
        Q <= D;
    end if;
end process;
--
