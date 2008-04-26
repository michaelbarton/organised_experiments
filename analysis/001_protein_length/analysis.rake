require 'zlib'

require 'rubygems'
require 'bio'

desc 'Repeat all protein length analysis'
rake :rebuild_001 => [:load_sequences]

desc 'Loads the protein sequences into the databases'
rake :load_sequences do

  # Delete all existing data
  #Genes.delete :all

  file_gz = File.dirname(__FILE__) + 'data/protein.fasta.gz'

  Zlib::GzipReader.open(seqs) do |file|
    p Bio::FlatFile.auto(file).first
  end

end

