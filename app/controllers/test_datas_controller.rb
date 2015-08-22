class TestDatasController < ApiController

	def index
		test_data=Test.all

		render :json=>test_data.to_json
	end

	def show
		data = params[:id]

		test_data=Test.create(:test_data=>data)
		redirect_to test_datas_path
	end


	def data_paramas
	end
end
