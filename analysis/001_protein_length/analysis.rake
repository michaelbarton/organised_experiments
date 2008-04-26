require 'zlib'
require 'open-uri' 

require 'rubygems'
require 'bio'
require 'google_chart'

namespace '001' do

  desc 'Repeat all protein length analysis'
  task :build => [:load_sequences,:sequence_stats]

  desc 'Delete all exiting sequences from the database'
  task :delete_sequences do
    Gene.delete :all
  end

  desc 'Loads the protein sequences into the databases'
  task :load_sequences => :delete_sequences do
    file_gz = File.dirname(__FILE__) + '/data/protein.fasta.gz'
    Zlib::GzipReader.open(file_gz) do |file|
      Bio::FlatFile.auto(file).each {|entry| Gene.create_from_flatfile entry }
    end
  end

  desc 'Calculates statistics for gene sequences'
  task :sequence_stats do
    File.open(File.dirname(__FILE__) + '/results/sequence_statistics.txt','w') do |file|
      file.puts "Gene mean length : #{ Gene.mean_length }"
      file.puts "Gene length standard deviation : #{ Gene.sd_length }"
    end
  end

  desc 'Plots histogram of the sequences lengths'
  task :length_histo do
    freq_table = Gene.bin_sequence_length(10)
    
    size = '600x200'
    title = nil
    colour = '76A4FB'
    chart_url =  GoogleChart::BarChart.new(size,title,:vertical) do |chart|
      freq_table.sort {|x,y| x.first.begin <=> y.first.begin}.each do |entry|
        chart.data entry[0].to_s, [Math.log10(entry[1] + 0.0001)], colour
      end
      chart.axis :x, :labels => ['Gene size (DNA)'],   :postion => 5
      chart.axis :y, :labels => ["Frequency (log10)"], :alignment => :right
    end

    File.open(File.dirname(__FILE__) + '/results/gene_length.png','w') do |file|
      file.puts open(chart_url.to_escaped_url).read
    end
  end

end
