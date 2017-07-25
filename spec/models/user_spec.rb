require 'rails_helper'

RSpec.describe User, type: :model do
  def valid_attributes(new_attributes = {})
    FactoryGirl.attributes_for(:user).merge(new_attributes)
  end

  describe 'validations' do
    it 'requires a first_name' do
      user = User.new (valid_attributes.merge(first_name: nil))
      expect(user).to be_invalid
    end

    it 'requires a last_name' do
      user = User.new (valid_attributes.merge(last_name: nil))
      expect(user).to be_invalid
    end
    it 'requires a email' do
      user = User.new (valid_attributes.merge(email: nil))
      expect(user).to be_invalid
    end

    it ' email must be unique' do
      user = User.create (valid_attributes.merge(email:'a@b.com'))
      user = User.new (valid_attributes.merge(email:'a@b.com'))
      expect(user).to be_invalid
    end

    it 'should have valid email' do
      user = User.create (valid_attributes.merge(email:''))
      expect(user).to be_invalid
    end
  end

  describe 'full_name method' do
    it 'should return full_name when the method is called' do
      user = User.create (valid_attributes.merge({first_name: "abby",last_name:'chow'}))

      expect("#{user.first_name} #{user.last_name}".titleize.strip).to eq user.full_name
    end
  end



end
