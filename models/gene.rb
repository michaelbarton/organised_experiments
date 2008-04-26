require 'rubygems'
require 'statarray'

class Gene < ActiveRecord::Base

  def self.create_from_flatfile(entry)
    Gene.create(
      :name      =>  entry.definition.split(/\s+/).first,
      :sequence  =>  entry.data     
    )
  end

  def self.mean_length
    genes = Gene.find(:all)
    genes.map{|gene| gene.sequence.length}.to_statarray.mean
  end

  def self.sd_length
    genes = Gene.find(:all)
    genes.map{|gene| gene.sequence.length}.to_statarray.stddev
  end

end
