require 'rails_helper'

describe Bird do
  context '#create' do
    context 'with valid params' do
      it 'all required params' do
        bird = Bird.new.tap do |b|
          b.family = "Penguin"
          b.name = "Penguin"
          b.continents = ["Antarctica"]
        end
        expect(bird.save).to be_truthy
      end
      it 'all required + added params' do
        bird = Bird.new.tap do |b|
          b.family = "Penguin"
          b.name = "Penguin"
          b.continents = ["Antarctica"]
          b.added = "2015-01-02"
        end
        expect(bird.save).to be_truthy
      end
      it 'all required + visible params' do
        bird = Bird.new.tap do |b|
          b.family = "Penguin"
          b.name = "Penguin"
          b.continents = ["Antarctica"]
          b.visible = true
        end
        expect(bird.save).to be_truthy
      end
      it 'respects current time to get UTC date' do
        Timecop.freeze(Time.now)
        bird = Bird.new
        expect(bird.added).to eq(Time.now.utc.to_s.split(' ')[0])
        Timecop.return
        future_date = 10.days.from_now
        Timecop.freeze(future_date)
        bird = Bird.new
        expect(bird.added).to eq(Time.now.utc.to_s.split(' ')[0])
        Timecop.return
      end
    end

    context 'with invalid params' do
      context 'fails when' do
        it 'name is missing' do
          bird = Bird.new.tap do |b|
            b.family = "Penguin"
            b.continents = ["Antarctica"]
          end
          expect(bird.save).to be_falsey
        end
        it 'family is missing' do
          bird = Bird.new.tap do |b|
            b.name = "Penguin"
            b.continents = ["Antarctica"]
          end
          expect(bird.save).to be_falsey
        end
        it 'continents are missing' do
          bird = Bird.new.tap do |b|
            b.name = "Penguin"
            b.family = "Penguin"
            b.continents = []
          end
          expect(bird.save).to be_falsey
        end
        it 'continents are not present' do
          bird = Bird.new.tap do |b|
            b.name = "Penguin"
            b.family = "Penguin"
          end
          expect(bird.save).to be_falsey
        end
      end
      it 'fails when added is not in the required format' do
        bird = build(:bird)
        bird.added = "2015 29 90"
        bird.save
        expect(bird.save).to be_falsey
      end
    end
  end
end
