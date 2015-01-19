module WisperCounterCache
  extend ActiveSupport::Concern

  included do
    include Wisper::Publisher

    attr_accessor :cached_accociations
    # @@cached_accociations

    after_create :increment_counter
    after_destroy :decrement_counter
    # after_initialize :wisper_counter_cache
  end

  # def wisper_counter_cache
  #   @cached_accociations ||= []
  #   self.class.wisper_counter_cache_attrs.each do |assoc|
  #     Rails.logger.info "ITERATE THROUGH assocs #{assoc} / wisper_counter_cache"
  #     assoc = { association: assoc[:association], column: (assoc[:column]||"#{self.class.name.pluralize.downcase}_counter") }
  #     @cached_accociations << assoc
  #     define_method("count_#{self.class.name.pluralize.downcase}") do
  #       send(assoc[:column])
  #     end
  #   end
  #   @cached_accociations
  # end

  module ClassMethods
    
    # class_variable_set("@@cached_accociations", [])

    def wisper_counter_cache_attrs(association, properties={})
      debugger
      @cached_accociations ||= []
      @cached_accociations << [association, properties]
    end

  end

  def increment_counter
    # debugger
    @cached_accociations.each do |assoc_to_increment|
      Rails.logger.info "ITERATE THROUGH assocs #{assoc_to_increment} / increment_counter"
      broadcast(:increment_counter_cache, self, assoc_to_increment[:association], assoc_to_increment[:column])
    end
  end

  def decrement_counter
    # debugger
    @cached_accociations.each do |assoc_to_decrement|
      broadcast(:decrement_counter_cache, self, assoc_to_decrement[:association], assoc_to_decrement[:column])
    end
  end

end
