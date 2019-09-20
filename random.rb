require 'pry'

sessions = [
  ["A", "B", "E"],
  ["A", "B", "D"],
  ["A", "C", "D"],
  ["B", "C", "E"],
  ["C", "D", "E"]
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
  attr_reader :topic, :time, :participants

  def initialize(topic, time)
    @topic = topic
    @time = time
    @participants = []
  end

  def register(participant)
    @participants.push(participant)
  end
end

class SessionTopic
  attr_reader :facilitator, :sessions
  
  FACILITATORS = [
    "Adam Horowitz / Gabrielle Uballez",
    "Pamela Villesenor",
    "Autumn White Eyes",
    "Halima Cassells",
    "Marlene Cancio Ramirez"
  ]

  def self.from_list(list)
    list.each_with_index.map do |sessions, i|
      new(FACILITATORS[i], sessions)
    end
  end

  def initialize(facilitator, sessions)
    @facilitator = facilitator
    @sessions = sessions.map do |time|
      Session.new(self, time)
    end
  end
end

class Participant
  attr_reader :name, :registered_sessions

  def self.from_list(list)
    list.map do |name|
      new(name)
    end
  end

  def initialize(name)
    @name = name
    @registered_sessions = []
  end

  def allowed_sessions(topic)
    registered_times = registered_sessions.map(&:time)
    topic.sessions.reject do |session|
      registered_times.include?(session.time)
    end
  end

  def register(session)
    puts "#{name} registered for #{session.time} with #{session.topic.facilitator}"
    @registered_sessions.push(session)
  end

  def complete_registration?
    @registered_sessions.length == 5
  end

  def reset!
    puts "#{name} reset!"
    @registered_sessions = []
  end
end

# shuffle participants
#
# for each participant
# #  for each topic
# #    which sessions are allowed for this participant?
# #    pick the session with least amount of people
# #    if tied, randomly pick a session

topics = SessionTopic.from_list(sessions)
participants = Participant.from_list(participant_list)

participants.shuffle.each do |participant|
  until participant.complete_registration?
    topics.each do |topic|
      allowed = participant.allowed_sessions(topic)
      allowed.length == 0 ?  participant.reset! : participant.register(allowed.sample)
    end
  end
end
