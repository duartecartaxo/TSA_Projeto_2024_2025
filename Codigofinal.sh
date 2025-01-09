#!/bin/bash

# Função para gerar golos aleatórios
generate_goals() {
  echo $(( RANDOM % 6 )) # Golos entre 0 e 5
}

# Função para simular um jogo
simulate_game() {
  local team1=$1
  local team2=$2

  local goals_team1=$(generate_goals)
  local goals_team2=$(generate_goals)

  echo "-------------------------------------"
  echo "Jogo: $team1 vs $team2"
  echo "Resultado: $team1 $goals_team1 - $goals_team2 $team2"
  echo "-------------------------------------"

  if [ "$goals_team1" -gt "$goals_team2" ]; then
    echo "$team1 venceu!"
    notify_loser "$team2"
    echo "$team1" # Retorna o vencedor
  elif [ "$goals_team1" -lt "$goals_team2" ]; then
    echo "$team2 venceu!"
    notify_loser "$team1"
    echo "$team2" # Retorna o vencedor
  else
    # Em caso de empate, determinar vencedor com "penalties"
    echo "Empate! Decidindo nos penalties..."
    local penalties_team1=$(( RANDOM % 5 + 1 ))
    local penalties_team2=$(( RANDOM % 5 + 1 ))
    echo "Penalties: $team1 $penalties_team1 - $penalties_team2 $team2"
    if [ "$penalties_team1" -ge "$penalties_team2" ]; then
      echo "$team1 venceu nos penalties!"
      notify_loser "$team2"
      echo "$team1" # Retorna o vencedor
    else
      echo "$team2 venceu nos penalties!"
      notify_loser "$team1"
      echo "$team2" # Retorna o vencedor
    fi
  fi
}

# Função para notificar equipas eliminadas
notify_loser() {
  local loser_team=$1
  echo " $loser_team foi eliminado do torneio."
}

# Entrada inicial: lista de equipas
read -p "Quantas equipas irão participar no torneio (potência de 2)? " num_teams

if (( num_teams < 2 )) || (( (num_teams & (num_teams - 1)) != 0 )); then
  echo "Erro: O número de equipas deve ser uma potência de 2 (ex.: 2, 4, 8, 16)."
  exit 1
fi

echo "Digite os nomes das $num_teams equipas:"
teams=()
for (( i = 0; i < num_teams; i++ )); do
  read -p "Equipa $((i + 1)): " team_name
  teams+=("$team_name")
done

# Simular o torneio
round=1
while (( ${#teams[@]} > 1 )); do
  echo "================= RONDA $round ================="
  next_round=()
  for (( i = 0; i < ${#teams[@]}; i += 2 )); do
    team1=${teams[i]}
    team2=${teams[i + 1]}
    winner=$(simulate_game "$team1" "$team2")
    next_round+=("$winner") # Apenas o vencedor avança
  done
  teams=("${next_round[@]}") # Atualizar lista de equipas para a próxima ronda
  round=$((round + 1))
done

# Anunciar o campeão
echo "====================================="
echo "CAMPEÃO DO TORNEIO: ${teams[0]} "
echo "====================================="


