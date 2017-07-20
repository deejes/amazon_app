require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let (:user) {FactoryGirl.create(:user)}
  let (:category) {FactoryGirl.create(:category)}
  let (:product) {FactoryGirl.create(:product, category: category)}
  let (:product_1) {FactoryGirl.create(:product, category: category, user: user)}

  describe 'edit' do
    render_views
    context 'user signed in'do
      context 'user allowed to edit' do
        it 'renders an edit form' do
          request.session[:user_id] = user.id
          get :edit, { params: {id: product_1.id} }
          expect(response).to render_template(:edit)
        end
        it 'the edit form is prepopulated' do
          request.session[:user_id] = user.id
          get :edit, { params: {id: product_1.id} }
          # byebug
          expect(response.body.match(product_1.title)).not_to be_nil
        end
      end
      context 'user not allowed to edit' do
        it ' redirects to the home path' do
          request.session[:user_id] = user.id
          get :edit, { params: {id: product.id} }
          expect(response).to redirect_to(home_path)
        end

      end
    end
    context 'user not signed in' do
      it 'redirects to the sign up page' do
      product
      get :edit, { params: {id: product.id} }
      # get :edit { params: {id: product.id} }
      expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe 'update' do
    context 'the product is successfully updated'
      it 'updates the record' do
        request.session[:user_id] = user.id
        # product_1
        original_title = product_1.title
        attributes = FactoryGirl.attributes_for(:product)
        patch :update , {params:{id: product_1.id, product: attributes}}
        product_1.reload()
        expect(product_1.title).to_not eq(original_title)
      end

      it 'redirects to the updated product page' do
        request.session[:user_id] = user.id
        # product_1
        original_title = product_1.title
        attributes = FactoryGirl.attributes_for(:product)
        patch :update , {params:{id: product_1.id, product: attributes}}
        product_1.reload()
        expect(response).to redirect_to(product_path(product_1))
      end

    context ' the product is not updated'
      it 're renders the edit page with prepopulated data' do
        # request.session[:user_id] = user.id
        # product_1
        # original_title = product_1.title
        attributes = FactoryGirl.attributes_for(:product).merge(title: "")
        patch :update , {params:{id: product_1.id, product: attributes}}
        product_1.reload()
        expect(response).to render_template(:edit)
      end

  end

  describe 'new' do
    context 'user signed in' do
      it 'renders the new product page' do
        request.session[:user_id] = user.id
        get :new
        expect(response).to render_template(:new)
      end
      it 'assigns an instance variable to an empty product' do
        request.session[:user_id] = user.id
        get :new
        expect(assigns(:product)).to be_a_new(Product)
      end
    end
    context ' user not signed in' do
      it 'redirects the user to the sign in page' do

        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe 'create' do
    context 'user signed in' do
      before do
        request.session[:user_id] = user.id
      end
      it 'increases the product count by 1' do
        attributes = FactoryGirl.attributes_for(:product).merge(user_id: user.id, category_id: category.id)
        # byebug
        before_count = Product.count
        post :create,  params: {product: attributes}
        after_count = Product.count
        expect(after_count).to eq(before_count+1)
      end
      it 'redirects the user to the new product page' do
        attributes = FactoryGirl.attributes_for(:product).merge(user_id: user.id, category_id: category.id)
        post :create,  params: {product: attributes}
        # byebug
        # post :create,  params: {product: FactoryGirl.attributes_for(:product)}
        expect(response).to redirect_to(product_path(Product.last.id))
      end
    end
    context 'user not signed in' do
      it 'redirects the user to sign in page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe 'index' do
    it 'assigns an instance variable to all products' do
      product
      product_1
      get :index
      expect(assigns(:products)).to eq([product_1,product])
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'show' do
    it 'assigns an instance variable to given product' do
      product
      get :show, { params: {id: product.id} }
      expect(assigns(:product)).to eq(product)
    end
    it 'render the show page for the given project' do
      get :show, { params: {id: product.id} }
      expect(response).to render_template(:show)
    end

  describe '#update' do
    context ' user NOT signed in' do
      it 'redirects to the sign in page'
    end
  end

  describe 'destroy' do
    context 'with no user signed in ' do
      it 'redirects to the sign in page' do
        delete :destroy, {params:{id: product.id} }
        expect(response).to redirect_to(new_session_path)

      end
    end

    context 'user signed in' do
      context 'with non owner signed in' do
          before do
            request.session[:user_id] = user.id
            delete :destroy, {params:{id: product.id} }
          end
        it 'sets a flash alert message' do
          expect(flash[:alert]).to be
        end
        it 'redirects to product page' do
          expect(response).to redirect_to product_path(product)
        end
      end
      context 'with owner signed in' do
        before do
          request.session[:user_id] = user.id
        end
        it 'reduces the number of products in the database by 1' do
          product
          product_1
          before_count = Product.count
          delete :destroy, {params:{id: product_1.id} }
          after_count = Product.count
          expect(after_count).to eq(before_count-1)
        end
        it ' reduces the count of products by 1' do
          product_1
          expect{delete :destroy, {params:{id: product_1.id}}}.to change{Product.count}.by(-1)
        end
        it 'redirects to the products index page' do
          delete :destroy, {params:{id: product_1.id} }
          expect(response).to redirect_to(products_path)
        end
        it 'sets a flash notice message' do
          delete :destroy, {params:{id: product_1.id} }
          expect(flash[:notice]).to be
        end

      end
    end


    #
    # it 'deletes instance of the product with given id ' do
    #   product
    #   expect(Products.find(product.id)).to eq(nil)
    # end
    # it 'redirects to product path' do
    #
    # end
  end

  end

end
