class PicturesController < ApiController

	def create
		# name = params[:upload][:image].original_filename
		name = "temp.png"
    directory = "public/"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(params[:upload][:image].read) }
    flash[:notice] = "File uploaded"

		# image = MiniMagick::Image.open("public/1.jpg")
		# image2 = MiniMagick::Image.open("public/1.jpg")
		# @html = image.compare(image2)
		#讀取所有的原本圖片
		origin_records = Dir.glob("public/origin/*")
		#判斷所以的圖片是不是有成立
		# receive = jpg_to_png("public/8.jpg")
		# if(File.exist?('temp.png'))
		# 	File.delete('temp.png')
		# end

		# File.open('public/temp.png', 'w+') {|f|
  	#   	f.puts Base64.decode64(Base64.decode64(base_64_encoded_data))
		# }

		receive = "public/temp.png"
		# receive = jpg_to_png("temp.png")

		is_match = {:is_match =>false}
		origin_records.each do |origin|

			# pic_compare(jpg_to_png("public/7.jpg"),jpg_to_png("public/8.jpg"))

			@compare_result = pic_compare(origin,receive)

				# byebug

			if @compare_result[:pixels_changed_percen] > 90
				is_match ={:is_match => true}
				break
			end
		end
		#資料判斷
		# pic_compare(jpg_to_png("public/7.jpg"),jpg_to_png("public/8.jpg"))
		# jpg_to_png("public/7.jpg")
		render :json =>is_match
	end

	def show
		show=CheckResult.first
		if show.result
			render :text =>"t"
		else
			render :text =>"f"
		end
	end

	def create_pic

	end

	private

	def jpg_to_png(pic)
		pic_name = File.basename(pic.split('.').first)
		image = MiniMagick::Image.open(pic)
		image.resize "500x500"
		image.format "png"
		image.write "public/#{pic_name}.png"
		return "public/#{pic_name}.png"
		# AWS::S3::S3Object.store("image.png", thumb.to_blob, AWS_BUCKET, :content_type => 'image/png', :access => :public_read)
		end

	def pic_compare(pic1,pic2)
		images = [
		  ChunkyPNG::Image.from_file(pic1),
		  ChunkyPNG::Image.from_file(pic2)
		]

		diff = []

		images.first.height.times do |y|
		  images.first.row(y).each_with_index do |pixel, x|
		    diff << [x,y] unless pixel == images.last[x,y]
		  end
		end

		puts "pixels (total):     #{images.first.pixels.length}"
		puts "pixels changed:     #{diff.length}"
		puts "pixels changed (%): #{(diff.length.to_f / images.first.pixels.length) * 100}%"
		campare = {
								:pixels_total=>images.first.pixels.length,
								:pixels_changed=>diff.length,
								:pixels_changed_percen=>(diff.length.to_f / images.first.pixels.length) * 100
							}
		return campare
		# x, y = diff.map{ |xy| xy[0] }, diff.map{ |xy| xy[1] }

		# images.last.rect(x.min, y.min, x.max, y.max, ChunkyPNG::Color.rgb(0,255,0))
		# images.last.save('diff.png')
	end

	# def pic_params
	# 	params.require(:picture).permit(:picture,:account)
	# end
end
