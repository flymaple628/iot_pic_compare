class TestDatasController < ApiController

	def index
		test_data=Test.all.order(id: :desc)

		render :json=>test_data.to_json
	end

	def show
		data = params[:id]

		test_data=Test.create(:test_data=>data)
		redirect_to test_datas_path
	end

	def create
		# name = params[:upload][:image].original_filename
		name = "temp.png"
    directory = "public/"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(params[:upload][:image].read) }
    flash[:notice] = "File uploaded"
    redirect_to test_datas_path
	end

	def data_paramas
	end
end
