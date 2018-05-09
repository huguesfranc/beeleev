namespace :users do
  task set_professional_status_and_pack: :environment do
    count = User.count

    User.all.each.with_index do |user, n|
      user.update_columns professional_status: User.professional_statuses[:entrepreneur]
      Pack.free_access(user: user).save

      puts "#{n}/#{count}"
    end
  end
end
