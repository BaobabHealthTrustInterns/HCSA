class AdminController < ApplicationController
  def index
	render :layout => 'admin'
  end


	def third
		 @service =Service.all.delete_if{|service|service.name.blank?}
	
	end

	def forth
		@votes = Vote.all
		@satlevel = Satlevel.all
	 

	
		@result = Satlevel.joins(:votes)
		@result2 = @result.find_by_sql("select name, date, count(*) as 'total_votes' from satlevels left join votes on
 						satlevels.satlevel_id = votes.satlevel_id group by satlevels.satlevel_id ")
		
		
		@concern = Concern.joins(:vote_concerns)
		@concern2 = @concern.find_by_sql(" select name, count(*) as 'total' from vote_concerns join concerns on 
						   concerns.concern_id = vote_concerns.concern_id group by concerns.concern_id")

		
		@result = Satlevel.select('satlevels.name, votes.date, count(votes.*) as total_votes')
                                  .joins(:votes)
                                  .group('satlevels.name, votes.date')
                                  .order('satlevels.name, votes.date')		
		

	end

	
	def listservice
		@service = Service.all
	end

	def listconcerns
		@concerns = Concern.all
	end

	def addConcerns

	concerns = Concern.new(params[:add_concern])
    	

  	 	 if concerns.save
		  flash[:notice] = "Concern added."
   		   redirect_to :action=>"listconcerns"
    		end

	
	end

	def delconcern
 	@concern = Concern.find(params[:id]) 
	end 

	def destroy 
	Concern.find(params[:id]).destroy 
	flash[:notice] = "Concern deleted." 
	redirect_to(:action => 'listconcerns') 
	end 


	def login

	end

end




 