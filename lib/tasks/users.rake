namespace :users do
  task set_professional_status: :environment do
    count = User.count

    User.all.each.with_index do |user, n|
      user.update professional_status: :entrepreneur
      puts "#{n}/#{count}"
    end
  end

  task set_pack: :environment do
    count = User.count

    User.all.each.with_index do |user, n|
      user.update pack: Pack.free_access
      puts "#{n}/#{count}"
    end
  end
end
