
class QueriesController < ApplicationController
  
  def index
    @queries = Query.all.order('created_at DESC')#.paginate(:per_page => 10, :page => params[:page])
  end
  
  def show
    @query = Query.find(params[:id])
  end 
  
  
  def edit
    @query = Query.find(params[:id])
  end
  
  
  def destroy
    @query = Query.find(params[:id])
    @query.destroy
    
    redirect_to queries_path
  end
  
  def launch_preview 
    
    
    @query = Query.find(params[:id])
    @statement = @query.text
    @machines = @query.machines
    
    @array = Array.new()
    @array_dbs = Array.new()
    
    @query.databases.each do |db|
      @statement.gsub! '[DATABASE]', db.name
      @sqlObject = SQLData.new(db.machine.user,db.machine.passwd,db.machine.hostname, @statement)
      @array.push(@sqlObject.get_sql_data(true))
      @array_dbs.push(db.name)
      @statement.gsub! db.name, '[DATABASE]'
    end
    
    @array_columns = @sqlObject.get_sql_columns()
    
    render 'show'
    
    
    
  end
  
  def export_all 
    @query = Query.find(params[:id])
    
    Rails.application.executor.wrap do 
      zip_file_name = SQLDataThreads.new(@query).getSQLData
      
      
      complete_path = (Dir.pwd).to_s + '/' + zip_file_name 
      File.open(complete_path, 'r') do |f|
        send_data f.read, type: "mime/type", :filename => zip_file_name
      end
      File.delete(zip_file_name)
    end
    
    
  end
  
  
  def new
    @query = Query.new
    @databases = @query.databases
    
  end
  
  def create
    
    @query = Query.new(query_params)
    
    if @query.save
      redirect_to @query
    else
      render 'new'
    end
  end
  
  
  def update 
    
    
    @query = Query.find(params[:id])
    
    if @query.update(query_params)
      
      
      redirect_to @query
    else
      render 'edit'
    end
    
    
  end
  
  
  
  private
  def query_params
    params.require(:query).permit(:title, :text, database_ids: [])
  end
  
  
  
end


