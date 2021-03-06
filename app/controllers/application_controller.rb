class ApplicationController < Sinatra::Base
  enable :sessions
  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  set :public_folder, "public"

  get '/' do
    if is_logged_in?
      redirect to '/experiences'
    end
    erb :index
  end

  helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def is_empty?(user_hash, route)
      user_hash.each do |att, val|
        if val.empty?
          flash[:empty] = "Please complete all fields."
          redirect to "/#{route}"
        end
      end
    end
  end

end
