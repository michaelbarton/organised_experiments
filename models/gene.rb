class Gene < ActiveRecord::Base

  def self.create_from_flatfile(entry)
    Gene.create(
      :name      =>  entry.definition.split(/\s+/).first,
      :sequence  =>  entry.data     
    )
  end

end
