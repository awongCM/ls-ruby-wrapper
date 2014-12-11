#TODO: Refactor this class 

module RLs
  class Application
    
    def initialize(argv)
        @params, @foldersfiles = parse_options(argv)
        @filesenum = []
    end

    def run
       filter(@foldersfiles, @params)
    end

    def parse_options(argv)
      params = {:list_viewing_info => :exclude_trailling_dots }
      global_switches = "ABCFGHLOPRSTUWabcdefghiklmnopqrstuwx1"

      parser = OptionParser.new    
      parser.on("-a") { params[:list_viewing_info] = :all_files_folders }
      parser.on("-l") { params[:file_listings] = :file_folders_stats}
      
      begin
        foldersfiles = parser.parse(argv) #save directory parameter    
      rescue OptionParser::InvalidOption => err
        abort "ruby-ls: #{err.message.gsub('invalid', 'illegal')}\nusage: ruby-ls [-ABCFGHLOPRSTUWabcdefghiklmnopqrstuwx1] [file ...]"
      end

      foldersfiles[0] ||= Dir.pwd

      [params, foldersfiles] 
    end

    private

    attr_reader :list_viewing_info

    def filter(foldersfiles, params)
      @list_viewing_info = params[:list_viewing_info]
      
      if foldersfiles.length <= 1
          begin
            @filesenum = Dir.entries(foldersfiles[0]).to_enum  
          rescue Errno::ENOENT => err
            abort "ruby-ls: #{foldersfiles[0]}: No such file or directory"
          end
          
          case list_viewing_info
          when :all_files_folders
            @filesenum = @filesenum.select
          when :exclude_trailling_dots
            @filesenum = @filesenum.reject{ |f| f=~ /^\.*\S$|\.DS_Store/ } #reject any files with trailing "dots"                  
          end               

          if params[:file_listings] == :file_folders_stats
              @filesenum = @filesenum.map { |i| "#{foldersfiles[0]}/#{i}" } if File.directory?(foldersfiles[0]) #check if given a directory parameter
              @filesenum = retrievefilefolderenum(@filesenum, foldersfiles[0])
          end
          
          display(@filesenum)

      else 
          foldersfiles.each do |f|     
              truncate(f) if params[:file_listings] == nil
              display_file_stat(f) if params[:file_listings] == :file_folders_stats
          end
      end

    end

    def display_file_stat(filesfolders)
        file_stat = File.stat(filesfolders)
        filename_s = filesfolders.to_s
        mtime_s = file_stat.mtime.strftime("%e %b %H:%M")
        size_s =  file_stat.size
        group_s = Etc.getgrgid file_stat.gid
        owner_s = Etc.getpwuid file_stat.uid
        nlink_s = file_stat.nlink
        perms_s = (file_stat.mode & 0777).to_s(8).chars.map { |perm|
          perm = Integer(perm)
          [4,2,1].zip("rwx".chars).map { |val, name|
            perm & val == 0 ? "-" : name
          }.join
        }.join
        entrytype_s = {"file" => "-", "directory"=>"d" }[file_stat.ftype]
        h = {:permissions => "#{entrytype_s}#{perms_s}", :nlink => "%2s"%"#{nlink_s}", :owner => owner_s.name, :group => "%6s"%"#{group_s.name}", :size => "%2s"%"#{size_s}", :mtime => mtime_s, :filename => filename_s}
        puts h.map{|k,v| v } * " "
    end

    def display(data)
       data.each do |k|
         puts "#{k}"
       end        
    end

    def truncate(filesfolders)
       if File.directory?(filesfolders)
         file_folder_to_slice = "#{Dir.pwd}/"
         puts Dir["#{file_folder_to_slice}#{filesfolders}"][0].slice! file_folder_to_slice 
       else
         puts filesfolders
       end
    end

    def retrievefilefolderenum(filesenum, foldername)
        @filefolderlistingenum = []
        
        #print out totals block size
        stats = filesenum.map { |file| File.stat(file) }
        blocks = stats.select(&:file?).map(&:blocks).reduce(0, :+)
        max_size_length = stats.map(&:size).max.to_s.length
        puts "total #{blocks}" unless !filesenum.any?

        filesenum.each do |f|
            file_stat = File.stat(f)
            filename_s = f.to_s
            mtime_s = file_stat.mtime.strftime("%e %b %H:%M")
            size_s =  file_stat.size
            group_s = Etc.getgrgid file_stat.gid
            owner_s = Etc.getpwuid file_stat.uid
            nlink_s = file_stat.nlink
            perms_s = (file_stat.mode & 0777).to_s(8).chars.map { |perm|
              perm = Integer(perm)
              [4,2,1].zip("rwx".chars).map { |val, name|
                perm & val == 0 ? "-" : name
              }.join
            }.join
            entrytype_s = {"file" => "-", "directory"=>"d" }[file_stat.ftype]

            h = {:permissions => "#{entrytype_s}#{perms_s}", :nlink => "%2s"%"#{nlink_s}", :owner => owner_s.name, :group => "%6s"%"#{group_s.name}", :size => "%5s"%"#{size_s}", :mtime => mtime_s, :filename => filename_s.gsub(/#{foldername}\//,"")}
            @filefolderlistingenum.push(h.map{|k,v| v } * " ")

        end
        @filefolderlistingenum        
    end
    
  end
end