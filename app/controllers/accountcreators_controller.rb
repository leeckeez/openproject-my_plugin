class AccountcreatorsController < ApplicationController

	##include CustomFieldsHelper
  #include OmniauthHelper
  #include Concerns::OmniauthLogin
  #include Concerns::RedirectAfterLogin
  #include Concerns::AuthenticationStages
  #include Concerns::UserConsent

	layout 'admin'

	before_action :require_admin  #require admin to access the page

	menu_item :info, only: [:info]

	def index
		@users = User.all
		@user = User.current

	end

	def show
		@users = Accountcreator.getUsers
	end

	def new
		@user = User.new
	end

	def edit
		@users = Accountcreator.getUsers
	end
=begin

	def create
		@user = User.new(user_params)

		respond_to do |format|
			if @user.save
				format.html { redirct_to @user, notice: 'Users were successfully created.' }
				format.json { render action: 'show', status: :created, location: @user }
			else
				format.html { render action: 'new' }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
      if @user.update(company_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	end

	def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
=end
	def import
		begin
    	Accountcreator.import(params[:file])
    	redirect_to users_path, notice: "Users Added Successfully and Groups Created Successfully"
			#redirect_to edit_accountcreator_path
		rescue
			redirect_to accountcreators_url, notice: "No file chosen!"
		end
  end






	private

		def set_user
			@user = User.find(params[:id])
		end

		def user_params
			params.require(:user).permit(:login, :firstname, :lastname, :mail)
		end



end
