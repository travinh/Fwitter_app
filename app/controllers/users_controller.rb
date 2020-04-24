class UsersController < ApplicationController 

    get '/login' do 
        erb :"users/login"
    end


    post "/login" do 
        user = User.find_by(email:params[:email])

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect "/tweets"
        else
            redirect "/login"
        end
    end

    get "/logout" do 
        session.clear 
        redirect '/login'
    end

    get "/signup" do 
        erb :"users/create_user"
    end

 
    post "/signup" do 
        user = User.create(params[:user])
        if user.errors.empty?
            session[:user_id] = user[:id]
            redirect "/tweets"
        else
            redirect "/signup"

        end
        

    end

    get "/show" do 
        if logged_in?
            @user = current_user
            @tweets = @user.tweets.all
            erb :"users/show"
        else 
            redirect '/login'
        end
        
    end
   


end