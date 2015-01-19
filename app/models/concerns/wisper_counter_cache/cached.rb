module WisperCounterCache::Cached

  after_initialize :define_cc_getters

  attr_accessor :cached_accociations

  def define_cc_getters
    (@cached_accociations||[]).each do |assoc|
      define_method("count_#{self.class.name.pluralize.downcase}") do
        send(assoc[:column])
      end      
    end
  end


end
