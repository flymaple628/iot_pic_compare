class TestDatasController < ApiController

	def show
		data = params[:id]

		test_data=Test.create(:test_data=>data)

	end


	def data_paramas
	end
end
