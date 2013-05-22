class Blume
	def initialize(options_in = {})
		options = {collection: nil,
            content_directory: File.join(Dir.pwd, 'content'),
           living_dangerously: true,
               		 root_url: 'http://localhost:4567',
               site_directory: File.join(Dir.pwd, 'site'),
               		   assets: File.join(Dir.pwd, 'public')
             }.merge(options_in)
		@collection = options[:collection]
		@content_directory = options[:content_directory]
		@living_dangerously = options[:living_dangerously]
		@pilgrim = Pilgrim.new(options[:root_url], options[:site_directory], options[:assets])
	end

	def build_collection()
		@collection.remove()
		walk @content_directory
	end

	def generate_site(compress = true)
		@pilgrim.generate(compress)
	end

	def walk(path)
		Dir.foreach(path) do |f|
			unless f[0] == '.'
				file = File.join(path, f)
				if File.directory?(file)
					walk file
				else
					@collection.insert(parse(file, path))
				end
			end
		end
	end

	def parse(file, path)
		post = YAML.load_file(file)
		post['type'] = path.sub(@content_directory,'').gsub(/\//, '-')[1..-1]
		post['title'] = File.basename(file,File.extname(file))[11..-1]
		post['date_time'] = Date.parse(File.basename(file, File.extname(file))[0..11]).
			to_time
		body = ""
		if @living_dangerously
			body = evil_mark(File.open(file,'rb').read.sub(/\-\-\-.*\-\-\-/m,'').lstrip)
		else
			body = File.open(file,'rb').read.sub(/\-\-\-.*\-\-\-/m,'').lstrip
		end
		post['body'] = RedCloth.new(body).to_html
		return post
	end


	def evil_mark text
		part = text.partition(/[^\\]\#{.*?}/)
		return_string = part[0]
		until part[1] == ""
			return_string << eval("\"" + part[1] + "\"")
			part = evil_mark(part[2]).partition(/[^\\]\#{.*?}/)
			return_string << part[0]
		end
		return_string.gsub!(/\\\#{.*?}/){|s| s[1..-1]}
		return return_string
	end
end