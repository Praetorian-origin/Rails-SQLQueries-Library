class DatabasesController < ApplicationController

  def new
    @database = Database.new
  end

  def create

    @database = Database.new(database_params)

    if @database.save
          redirect_to databases_path
    else render 'new'
    end


  end


  def edit
    @database = Database.find(params[:id])
  end


  def update

    @database = Database.find(params[:id])

    if @database.update(database_params)
           redirect_to databases_path
    else render 'new'
    end


  end

  def destroy

    @database = Database.find(params[:id])
    @database.destroy
    redirect_to databases_path
  end

  def index
    @databases = Database.all #.order(' DESC')
  end

  def show
    @database = Database.find(params[:id])
  end

  private
  def database_params
    params.require(:database).permit(:name, :machine_id, query_ids: [])

  end

end
