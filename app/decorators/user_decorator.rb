class UserDecorator < Draper::Decorator
  delegate_all

  def active_network
    network.reject{ |u| !u.try(:active?) }
  end

  def network
  	connections_received + connections_sent
  end

  def connections_received
  	user2_connections.map &:user1
  end

  def connections_sent
  	user1_connections.map &:user2
  end

  def full_capitalized_name
  	first_name.to_s.upcase + " " + last_name.to_s.upcase
  end

  def full_titleized_name
    first_name.to_s.titleize + " " + last_name.to_s.titleize
  end

  def position_at_company
    position.to_s + " @" + company.to_s
  end

  def all_spoken_languages
    spoken_languages.map{ |spoken_language| spoken_language.to_s.capitalize }.sort.join ', '
  end
end
