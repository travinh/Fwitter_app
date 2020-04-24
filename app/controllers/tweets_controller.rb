class TweetsController < ApplicationController 

  
    get "/tweets" do
        if logged_in?
            @user = current_user
            @tweets = Tweet.all
            erb :"tweets/tweets"
        else 
            redirect '/login'
        end
        
    end

    get "/tweets/new" do 
        if logged_in?
            erb :"tweets/new"
        else 
            redirect '/login'
        end
        
    end

    get "/tweets/:id" do
        
        if logged_in?
            id = params[:id]
            @tweet = Tweet.find_by_id(id)
            
            if @tweet 
                erb :"tweets/show_tweet"
            else 
                redirect "/tweets"
            end
        else 
            redirect '/login'
        end
        
        
    end

    post "/tweets" do 

        if logged_in?
            tweet = Tweet.new(params[:tweet])
            tweet.user_id = current_user[:id]
            if tweet.save
                redirect "/tweets/#{tweet.id}"
            else
                redirect "/tweets/new"
            end
        else 
            redirect '/login'
        end
       
    end


    get "/tweets/:id/edit" do

        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet 
                erb :"tweets/edit_tweet"
            else 
                redirect "/tweets"
            end
        else 
            redirect '/login'
        end
        
    end

    patch "/tweets/:id" do
        
        if logged_in?
            tweet = Tweet.find_by_id(params[:id])

            if tweet.update(params[:tweet])
                redirect "/tweets/#{tweet.id}"
            else
                redirect "/tweets/#{tweet.id}/edit"
            end
        else 
            redirect '/login'
        end
        
    end

    delete "/tweets/:id" do 
        if logged_in?
            tweet = Tweet.find_by_id(params[:id])

            if tweet.destroy 
                redirect "/tweets"
            else
                redirect "/tweets/#{tweet.id}"
            end
        else 
            redirect '/login'
        end
        
       
    end

   

    

  


end