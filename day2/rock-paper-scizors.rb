#Opponent:  A- Rock | B- Paper | C- Scizors
#Player:    X- Rock | Y- Paper | Z- Scizors

#   Scoring
#Play        : 1- Rock | 2- Paper | 3- Scizors
#Round Result: 0- Lost | 3- Draw  | 6- Won

def play_game
  plays = { rock: { vs_rock: 0, vs_paper: -1, vs_scizors: 1 }, 
            paper: { vs_paper: 0, vs_rock: 1, vs_scizors: -1 }, 
            scizors: { vs_scizors: 0, vs_rock: -1, vs_paper: 1 } 
          }

  players_plays = { A: { label: 'rock', points: 1 }, 
                    B: { label: 'paper', points: 2}, 
                    C: { label: 'scizors', points: 3},  
                    X: { label: 'rock', points: 1 }, 
                    Y: { label: 'paper', points: 2}, 
                    Z: { label: 'scizors', points: 3} 
                  }

  rounds_plays = File.open("strategy-guide.txt").read.split("\n")

  total_opponent_score = 0
  total_player_score = 0
  index = 0
  rounds_plays.each do |round_play|
    round_play = round_play.split(" ")
    
    opponent_round_score = 0
    player_round_score = 0

    opponent_play_score = players_plays[round_play[0].to_sym][:points]
    player_play_score = players_plays[round_play[1].to_sym][:points]

    opponent_play = plays[players_plays[round_play[0].to_sym][:label].to_sym]
    player_play = "vs_#{players_plays[round_play[1].to_sym][:label]}".to_sym

    if opponent_play[player_play] > 0
      opponent_round_score += (opponent_play_score + 6)
      player_round_score += (player_play_score)
    elsif opponent_play[player_play] < 0
      opponent_round_score += (opponent_play_score)
      player_round_score += (player_play_score + 6)
    else
      player_round_score += (player_play_score + 3)
      opponent_round_score += (opponent_play_score + 3)
    end
    total_opponent_score += opponent_round_score
    total_player_score += player_round_score
  end
  puts "Player's Score: #{total_player_score}"
  puts "Opponent's Score: #{total_opponent_score}"
end

play_game