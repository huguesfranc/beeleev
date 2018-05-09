namespace :users do
  task set_professional_status: :environment do
    count = User.count

    User.all.each.with_index do |user, n|
      user.update_column :professional_status, :entrepreneur
      puts "#{n}/#{count}"
    end
  end

  task set_pack: :environment do
    count = User.count

    User.all.each.with_index do |user, n|
      user.update_column :pack_id, Pack.create(kind: :free_access).id
      puts "#{n}/#{count}"
    end
  end
end
