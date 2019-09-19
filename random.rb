session_list = [
  [1, 3, 2],
  [1, 4, 2],
  [5, 4, 3],
  [5, 2, 3],
  [5, 1, 4]
]

participant_list = [
  "Janice Bad Moccasin",
  "Sharon Day",
  "Ligaiya Romero",
  "Ingrid LaFleur",
  "Shane Bernardo",
  "Kyla Farmer",
  "Piper Carter",
  "Mïïgun",
  "Njia Kai",
  "Sacramento Knoxx",
  "Kealoha Ferreira",
  "Alexandra Eady",
  "Sir Curtis Kirby III",
  "Bryan Thao Worra",
  "Kathy Mouacheupao",
  "Anh-Thu Pham",
  "Rebecca Nicholson",
  "Clarence White",
  "Clementine Bordeaux",
  "Ariel Davis",
  "Free Egunfemi",
  "Aimee McCoy",
  "Michael Sakamoto",
  "Jordana De La Cruz",
  "Sonia Guinansaca",
  "Kristen Calhoun",
  "Eve LaFountain",
  "Ryan Pearson",
  "Ananya Chatterjea",
  "Gary Peterson",
  "Meena Naarajan",
  "Dipankar Mukherjee",
  "Roberta Uno",
  "Kassandra Khalil",
  "Kapena Alapai",
  "Elizabeth Webb",
  "Morgan Camper",
  "Natalie Marrero",
  "Sarah Yanni",
  "Juan Carlos Herrera",
  "Evelyn Hang Yin",
  "Vinhay Keo",
  "Music Center designated - TBD",
  "Garth Ross (Schwartzman Center)",
  "Susie Lundy",
  "Suzanne Cross",
  "Andrea Reynolds"
]

class Session
  attr_reader :id, :time

  def self.from_list(list)
    list.each_with_index.map do |session, index|
      session.map do |id|
        new(id, index)
      end
    end
  end

  def initialize(id, time)
    @id = id
    @time = time
  end
end

class Participant
  attr_reader :name

  def self.from_list(list)
  end

  def initialize(name)
    @name = name
  end
end


#
# RULES
#
# 1. all partipants attend all 5 sessions
# 2. no chapter session should be the same as another
# 3. groups should be < 20 people (balance them)
#

class ScheduleGenerator
  attr_reader :participants, :sessions

  def initialize(participants, sessions)
    @participants = participants
    @sessions = sessions
  end

  def random_schedule
    puts "PARTICIPANTS"
    puts participants.to_s
    puts "SESSIONS"
    puts sessions.to_s
  end
end

participants = Participant.from_list(participant_list)
sessions = Session.from_list(session_list)
ScheduleGenerator.new(participants, sessions).random_schedule
