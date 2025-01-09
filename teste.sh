#!/bin/bash

# Função para gerar golos aleatórios
generate_goals() {
  echo $(( RANDOM % 6 )) # Golos entre 0 e 5
}

# Solicitar os nomes das equipas
read -p "Digite o nome da primeira equipa: " team1
read -p "Digite o nome da segunda equipa: " team2

# Gerar os resultados
goals_team1=$(generate_goals)
goals_team2=$(generate_goals)

# Exibir o resultado
echo "-------------------------------------"
echo "Resultado do jogo: $team1 vs $team2"
echo "$team1 $goals_team1 - $goals_team2 $team2"
echo "-------------------------------------"

# Determinar o vencedor
if [ "$goals_team1" -gt "$goals_team2" ]; then
  echo "Vencedor: $team1 "
elif [ "$goals_team1" -lt "$goals_team2" ]; then
  echo "Vencedor: $team2 "
else
  echo "O jogo terminou empatado!"
fi
