class Pilgrim
	def initialize(root_url, site_directory, assets)
		@root_url = root_url
		@site_directory = site_directory
		@assets = assets
		@asset_folders = Dir.glob(@assets).
			reject{|f| not File.directory?(f)}.
			map{|d| "/" + d + "/"}
	end

	def generate(compression_on = true)
		visited = Set.new
		unvisited = Set.new [@root_url]
		FileUtils.rm_rf(@site_directory)
		while !unvisited.empty?
			parse_page(visited, unvisited)
		end
		FileUtils.cp_r(Dir[@assets + "/*"], @site_directory)
		if compression_on then compress end
	end

	def compress()
		Find.find(@site_directory) do |f_name|
			ext = File.extname(f_name)
			if ext == '.html' || ext == '.js' || ext == '.css'
				File.open(f_name,'rb') do |f|
					File.open(f_name + ".gz", 'w') do |gz_f|
						gz = Zlib::GzipWriter.new(gz_f)
						gz.write(f.read)
						gz.close
					end
				end
			end
		end
	end

	def parse_page(visited, unvisited)
		current = unvisited.take(1)
		visited << current[0]
		page = Nokogiri::HTML(open(current[0]))
		page.css('a').each do |p|
			if p['href'].start_with? "/"
				unless visited.include? @root_url + p['href'] or @asset_folders.any?{|d| p['href'].start_with? d}
					unvisited << @root_url + p['href']
				end
			end
		end
		save_file(page, current)
		unvisited.subtract(current)
	end

	def save_file(page, file)
		path = @site_directory + file[0].sub(@root_url, "/")
		FileUtils.mkpath(path)
		File.open(path + "/index.html", "w"){|f| f.write(page.to_html)}
	end
end