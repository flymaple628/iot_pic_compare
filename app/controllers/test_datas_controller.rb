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
		data = params[:data]
		# render :json=>data

		data_url = data
		png      = Base64.decode64(data_url['data:image/png;base64,'.length .. -1])
		File.open('/public/test.png', 'wb') { |f| f.write(png) }
		# test_data=Test.create(:test_data=>data)
		test_data=Test.create(:test_data=>png)
		# redirect_to test_datas_path
	end

	def data_paramas
	end
end
