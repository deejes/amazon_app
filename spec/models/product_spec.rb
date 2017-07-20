require 'rails_helper'
RSpec.describe Product, type: :model do
  # describe 'validations' do
    describe 'title' do
      it('must be present') do
        u = Product.new(title:'Arubberduck', description:"this is a big ass large rubber duck", price:23)
        u.title = nil
        u.valid?
        expect(u.errors).to have_key(:title)
      end
    it('must be unique') do
      u = Product.create(title:'Arubberduck', description:"this is a big ass large rubber duck", price:23)
      u2 = Product.new(title:'Arubberduck', description:"athis is a big ass large rubber duck", price:123)
      u2.valid?
      expect(u2.errors.messages).to have_key(:title)
    end

    # it('must be capitalized') do
    #   u = Product.new(title:'arubberduck', description:"this is a big ass large rubber duck", price:23)
    #   u.valid?
    #   expect(u.title).to eq('Arubberduck')
    # end
  end
   describe 'description' do
     it('must be present') do
       u = Product.create(title:'Arubberduck', description:"this is a big ass large rubber duck", price:23)
       u.description = nil
       u.valid?
       expect(u.errors.messages).to have_key(:description)
     end
   end

   describe 'price' do
     it('must be present') do
       u = Product.create(title:'Arubberduck', description:"this is a big ass large rubber duck", price:23)
       u.price = nil
       u.valid?
       expect(u.errors.messages).to have_key(:price)
     end

     it('must be more than zero') do
       u = Product.create(title:'Arubberduck', description:"this is a big ass large rubber duck", price:23)
       u.price = -1
       u.valid?
       expect(u.price).to be < 0
     end

   end
  end
