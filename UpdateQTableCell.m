function [value] = UpdateQTableCell(stato, azione, max_next_state, reward, Algo)
% Funzione di aggiornamento della QTable
    value = Algo.current_Qtable{stato, azione}.reward + Algo.alpha * (reward + Algo.gamma * max_next_state - Algo.current_Qtable{stato, azione}.reward);
end