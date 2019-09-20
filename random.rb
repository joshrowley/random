require 'pry'

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
  attr_reader :id, :time, :participants

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
    @participants = []
  end

  def name
    "#{time} #{facilitator}"
  end

  def facilitator
    case @id
    when 1
      "Adam Horowitz / Gabrielle Uballez"
    when 2
      "Pamela Villesenor"
    when 3
      "Autumn White Eyes"
    when 4
      "Halima Cassells"
    when 5
      "Marlene Cancio Ramirez"
    end
  end

  def time
    case @time
    when 0
      "A"
    when 1
      "B"
    when 2
      "C"
    when 3
      "D"
    when 4
      "E"
    end
  end

  def add_participant(participant)
    @participants << participant
  end
end

class Participant
  attr_reader :name, :sessions

  def self.from_list(list)
    list.map do |name|
      new(name)
    end
  end

  def initialize(name)
    @name = name
    @sessions = []
  end

  def add_session(session)
    @sessions << session
  end

  def can_accept_session?(session)
    !sessions.map(&:id).include?(session.id)
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
  attr_reader :participants, :sessions, :schedule

  def initialize(participants, sessions)
    @participants = participants
    @sessions = sessions
  end

  def random_participant(pluck_copy)
  end

  def random_schedule
    puts "#{ sessions.length } sessions"
    puts "#{ participants.length } participants"
    puts "Creating schedule"

    # each time block
    sessions.each do |time_block|
      pluck_copy = participants.dup.shuffle
      
      time_block.cycle do |session|

        match = false
        until match
          participant = pluck_copy.shift
          # if !participant
            # binding.pry
          # end
          if participant.can_accept_session?(session)
            participant.add_session(session)
            session.add_participant(participant)
            puts "Added #{participant.name} to session #{session.id} #{session.time}"
            match = true
          else
            puts "Didn't match #{participant.name}, retrying..."
            pluck_copy.push(participant)

            if pluck_copy.all? { |p| !p.can_accept_session?(session) }
              puts "skipping to next session, no participants available"
              next
            end
          end
        end

        pluck_copy.compact!

        if pluck_copy.length == 0
          break
        end
      end
    end

    sessions.each_with_index do |seshes, i|
      puts "\nSESSION #{seshes.first.time}\n\n\n"

      seshes.each do |s|
        puts "Session #{ s.time } #{ s.facilitator }\n\n"
        
        puts s.participants.map(&:name)
        puts "\n\n"
      end
    end

    participants.each do |p|
      puts "\n\n #{p.name}'s schedule\n\n"
      puts p.sessions.map(&:name)
    end
  end
end

participants = Participant.from_list(participant_list)
sessions = Session.from_list(session_list)
ScheduleGenerator.new(participants, sessions).random_schedule
