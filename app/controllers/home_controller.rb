class HomeController < ApplicationController
        before_action :authenticate_user!
  
	def index
		@status = 0
		length = `ps auxw | grep crawl.sh`.split("\n").size
		@index_count = indexCount
		puts @index_count
		if  length >= 3
			@status = 1
	        end
		@user = current_user
	end
	def indexCount
		`es -u #{INDEX_MASTER} count`
	end

	def hbaseCount
	end

	def start
		system("#{NUTCH_HOME}/crawl.sh > #{NUTCH_HOME}" + "/logs/start.txt" + "&")
		redirect_to :action=> 'index'
	end 

	def stop
		system("#{NUTCH_HOME}/stop.sh")
		redirect_to :action=> 'index'
	end

	def resume
		system("#{NUTCH_HOME}/resume.sh")
		redirect_to :action=> 'index'
	end

	def readFile
		filename = params[:filename]
		@data = File.read(NUTCH_HOME + filename)
		render :json => @data
	end

	def getLog
		@data = `tail -5 #{NUTCH_HOME}/logs/hadoop.log`
		render :json => @data
	end


	def saveFile
		filename = params[:filename]
		data = params[:data]
		File.open(NUTCH_HOME + filename, 'w') { |file| file.write(data) }
		operation = params[:operation]
		if operation == "insertUrl"
			puts "insertUrl"
			insertUrl
		end
		render :json => 0
	end
	def insertUrl
		system("#{NUTCH_HOME}/insert.sh > #{NUTCH_HOME}" + "/logs/insert.txt" + "&")
	end
	def get_seeds
		@data = File.read(NUTCH_HOME + '/urls/seed.txt')
		render :json => @data
	end

	def reboot
		system("#{NUTCH_HOME}/stop.sh")
		start
	end

	def hbaseStatus
	end
end
