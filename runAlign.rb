class RunEland

  attr_accessor :r1_files, :r2_files, :r1_files_array, :r2_files_array
  
  def initialize
    @dir_count = 0
    @r1_files = r1_files
    @r2_files = r2_files
    @r1_files_array = r1_files_array
    @r2_files_array = r2_files_array
    unzip_files()
  end

  def unzip_files()
    puts "Unzipping fastq files..."
		unzip = `/Users/cjose/Desktop/send_to_eland/./unzip.sh`
  end
  
  def sort_files()
    @dir_count += 1
    if @dir_count == 4
      puts "Grepping is finished for all directories."
      return true
    end 
    puts "Moving to next directory..."
    puts "Finding and sorting R1 files..."
    @r1_files = `find /Users/cjose/Desktop/fastq#{@dir_count} -name '*R1*' | sort`
    puts "Finding and sorting R2 files..."
    @r2_files = `find /Users/cjose/Desktop/fastq#{@dir_count} -name '*R2*' | sort`
    n = @r1_files, @r2_files
    split_into_array(n)
  end

  def split_into_array(n)
    @r1_files = n[0]
    @r2_files = n[1]
    puts "Putting files into array..."
    @r1_files_array = @r1_files.split("\n")
    @r2_files_array = @r2_files.split("\n")
    n = @r1_files_array, @r2_files_array
    send_to_eland(n)
  end
  
  def send_to_eland(n)
    file_count_r1 = n
    fastq_count = file_count_r1[1].length
    return fastq_count
    
    0.upto fastq_count do |file_index|
      break if file_index == 3
      puts "Grepping R1 and R2 files..."
      output = system "grep -L ^NTAAGGAA #{@r1_files_array[file_index]} #{@r2_files_array[file_index]} >> /Users/cjose/Desktop/out/out.txt"
      puts "Done grepping #{r1_files_array[file_index]} and #{r2_files_array[file_index]}"
    end
    unzip_files()
  end # end of method
  
end # end of class

e = RunEland.new
e.sort_files()