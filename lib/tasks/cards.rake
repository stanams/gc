namespace :cards do
  desc "Make 5 cards"
  task :recreate => :environment do
    RedemptionCard.destroy_all
    (1...100).each do |i|
      index = i.to_s.rjust(2, '0')
      card = RedemptionCard.create(
        card_code: "symphonycrocks#{index}",
        card_pin: '1234',
        amount: [10, 20, 30, 40].sample
      )
      puts '----------------------------'
      puts "#{card.card_code} | #{card.card_pin} | #{card.amount}"
    end
    puts '----------------------------'
  end
end
