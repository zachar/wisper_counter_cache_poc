module WisperCounterCache
  extend ActiveSupport::Concern

  included do
    include Wisper::Publisher

    cattr_accessor :cached_associations

    after_create :increment_counter
    after_destroy :decrement_counter
  end

  module ClassMethods

    def wisper_counter_cache_attrs(association, properties={})
      self.cached_associations ||= []
      self.cached_associations << { association: association }.merge(properties)
    end

  end

  def increment_counter
    self.class.cached_associations.each do |assoc_to_increment|
      broadcast(:increment_counter_cache, self, assoc_to_increment[:association], assoc_to_increment[:column])
    end
  end

  def decrement_counter
    self.class.cached_associations.each do |assoc_to_decrement|
      broadcast(:decrement_counter_cache, self, assoc_to_decrement[:association], assoc_to_decrement[:column])
    end
  end

end
