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
    echo "$team1" # Retorna o vencedor
  elif [ "$goals_team1" -lt "$goals_team2" ]; then
    echo "$team2 venceu!"
    echo "$team2" # Retorna o vencedor
  else
    # Em caso de empate, determinar vencedor com "penalties"
    echo "Empate! Decidindo nos penalties..."
    local penalties_team1=$(( RANDOM % 5 + 1 ))
    local penalties_team2=$(( RANDOM % 5 + 1 ))
    echo "Penalties: $team1 $penalties_team1 - $penalties_team2 $team2"
    if [ "$penalties_team1" -ge "$penalties_team2" ]; then
      echo "$team1 venceu nos penalties!"
      echo "$team1" # Retorna o vencedor
    else
      echo "$team2 venceu nos penalties!"
      echo "$team2" # Retorna o vencedor
    fi
  fi
}