require 'zlib'

require 'rubygems'
require 'bio'

namespace '001' do

  desc 'Repeat all protein length analysis'
  task :build => [:load_sequences]

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

end
