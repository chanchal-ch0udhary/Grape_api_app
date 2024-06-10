module V1
  class Users < Grape::API
    version 'v1', using: :path
    format :json
    
    resource :users do

      desc 'Return list of all users'
      get do
        User.all
      end
      
      desc 'Return a specific user'
      params do 
        requires :id,type: Integer,desc: 'User ID'
      end
      route_param :id do
        get do
          User.find(params[:id])
        end
      end
      
      desc 'Create a new User'
      params do
        requires :name,type: String,desc: "User Name"
        requires :email,type: String,desc: "User Email"
      end  
      post do
        User.create(name: params[:name],email: params[:email])
      end 
      
      desc 'Updating a existing User'
      params do
        requires :id,type: Integer,desc: "User ID"
        optional :name,type: String,desc: "User Name"
        optional :email,type: String,desc: "User Email"
      end
      put ':id' do
        user = User.find(params[:id])
        user.update(name: params[:name],email: params[:email])
        user
      end
      
      desc 'Delete a user'
      params do
        requires :id,type: Integer,desc: "User ID"
      end
      delete ':id' do
        user = User.find(params[:id])
        user.destroy
      end  

    end  
  end  
end  