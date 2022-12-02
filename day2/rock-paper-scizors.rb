#Opponent:  A- Rock | B- Paper | C- Scizors
#Player:    X- Rock | Y- Paper | Z- Scizors
#Round:     X- Won  | Y- Lost  | Z- Draw 
#   Scoring
#Play        : 1- Rock | 2- Paper | 3- Scizors
#Round Result: 0- Lost | 3- Draw  | 6- Won

PLAYS = { rock: { vs_rock: 0, vs_paper: -1, vs_scizors: 1 }, 
paper: { vs_paper: 0, vs_rock: 1, vs_scizors: -1 }, 
scizors: { vs_scizors: 0, vs_rock: -1, vs_paper: 1 } 
}

PLAYERS_PLAYS = { A: { label: 'rock', points: 1 }, 
        B: { label: 'paper', points: 2}, 
        C: { label: 'scizors', points: 3},  
        X: { label: 'rock', points: 1 }, 
        Y: { label: 'paper', points: 2}, 
        Z: { label: 'scizors', points: 3} 
      }

def play_game(scoringType)

  rounds_plays = File.open("strategy-guide.txt").read.split("\n")

  total_opponent_score = 0
  total_player_score = 0
  index = 0
  rounds_plays.each do |round_play|
    round_play = round_play.split(" ")
    
    opponent_round_score = 0
    player_round_score = 0

    opponent_play = PLAYS[PLAYERS_PLAYS[round_play[0].to_sym][:label].to_sym]

    opponent_play_score = PLAYERS_PLAYS[round_play[0].to_sym][:points]

    player_score_and_play= getPlayerScore(scoringType, round_play[1], opponent_play, "#{PLAYERS_PLAYS[round_play[1].to_sym][:label]}")

    player_play_score = PLAYERS_PLAYS[player_score_and_play[:score]][:points]
    player_play = "vs_#{player_score_and_play[:play]}".to_sym  
    
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
    index += 1
  end
  puts "Player's Score: #{total_player_score}"
  puts "Opponent's Score: #{total_opponent_score}"
end

def getPlayerScore(scoringType, playId, opponentPlay, vsPlayer)
  return { score: playId.to_sym, play: vsPlayer } if scoringType != 2
  label = ""
  case playId
    when 'X'
      label = opponentPlay.key(1).to_s.sub("vs_", "")
    when 'Y'
      label = opponentPlay.key(0).to_s.sub("vs_", "")
    when 'Z'
      label = opponentPlay.key(-1).to_s.sub("vs_", "")
  end
  score = nil
  case label
    when 'rock'
      score =  :A
    when 'paper'
      score =  :B
    when 'scizors'
      score =  :C
  end
  { score: score, play: label }
end

#Puzzle #1 - Assuming X,Y,Z were the equivalent of the player's play in each round
puts "Puzzle #1 \n"
play_game(1)
puts "\n \nPuzzle #2 \n"
#Puzzle #2 - Knowing that X,Y,Z means what should each round end as (win, lose, draw)
play_game(2)