class VideosController < ApplicationController
	respond_to :html, :json, :xml
	
	# GET /videos[.json/.xml]
	def index
		respond_with( @videos = Video.all )
	end

	# GET /videos/1[.json/.xml]
	def show
		respond_with( @video = Video.find(params[:id]) )
	end

	# GET /videos/new[.json/.xml]
	def new
		@video = Video.new
	end

	# GET /videos/1/edit
	def edit
		@video = Video.find(params[:id])
	end

	# POST /videos[.json/.xml]
	def create
		@video = Video.new(params[:video])
		@video.save
		respond_with( @video, :location => videos_path )
	end

	# PUT /videos/1[.json/.xml]
	def update
		@video = Video.find(params[:id])
		@video.update_attributes(params[:video])
		respond_with(@video) do |format|
			format.html
			format.xml { render :xml => @video }
			format.json { render :json => @video }
		end
	end

	# DELETE /videos/1[.json/.xml]
	def destroy
		@video = Video.find(params[:id])
		@video.destroy
		respond_with @video
	end
end
