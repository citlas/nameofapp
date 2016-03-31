require 'rails_helper'

describe UsersController, :type => :controller do
	
		before do
			#@user = User.create!(email: "abc@abc.abc", password: "abcabcabc")
      @user = FactoryGirl.create(:user)
      @user2 = User.create!(email: "def@def.def", password: "defdefdef")
			end
			
			describe "GET #show" do
				context "User is logged in" do
					before do
						sign_in @user
					end
					
					it "loads correct user details" do
						get :show, id: @user.id
						expect(response).to have_http_status(200)
						expect(assigns(:user)).to eq @user
					end
          
          it "first user cant access show page of second user" do
            get :show, id: @user.id
            expect(assigns(:user)).not_to eq @user2
            expect(response).to redirect_to(root_path)
          end

          it "loads correct user 2 details" do
            get :show, id: @user2.id
            expect(response).to have_http_status(302)
            expect(assigns(:user)).to eq @user2
          end

        end
				

				context "No user is logged in" do
					it "redirects to login" do
						get :show, id: @user.id
						expect(response).to redirect_to(root_path)
				end
			 end
		  end
end