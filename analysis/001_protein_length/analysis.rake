require 'zlib'

require 'rubygems'
require 'bio'

namespace '001' do

  desc 'Repeat all protein length analysis'
  task :build => [:load_sequences]

  desc 'Loads the protein sequences into the databases'
  task :load_sequences do

    # Delete all existing data
    #Genes.delete :all

    file_gz = File.dirname(__FILE__) + 'data/protein.fasta.gz'

    Zlib::GzipReader.open(seqs) do |file|
      p Bio::FlatFile.auto(file).first
    end

  end

end
