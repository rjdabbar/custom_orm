require_relative '02_searchable'
require 'active_support/inflector'

class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    self.class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    if options[:foreign_key].nil?
      @foreign_key = "#{name}Id".underscore.to_sym
    else
      @foreign_key = options[:foreign_key]
    end

    if options[:class_name].nil?
      @class_name =  name.to_s.camelcase
    else
      @class_name =  options[:class_name]
    end

    if options[:primary_key].nil?
      @primary_key =  :id
    else
      @primary_key =  options[:primary_key]
    end
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    if options[:foreign_key].nil?
      @foreign_key = "#{self_class_name}Id".underscore.to_sym
    else
      @foreign_key = options[:foreign_key]
    end

    if options[:class_name].nil?
      @class_name =  name.to_s.camelcase.singularize
    else
      @class_name =  options[:class_name]
    end

    if options[:primary_key].nil?
      @primary_key =  :id
    else
      @primary_key =  options[:primary_key]
    end
  end
end

module Associatable
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    assoc_options[name] = options

    define_method(name) do
      fkey = self.send(options.send(:foreign_key))
      klass = options.model_class
      klass.where({id: "#{fkey}"}).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self, options)

    define_method(name) do
      fkey = options.send(:foreign_key)
      klass = options.model_class
      klass.where({"#{fkey}" => "#{self.id}"})
    end
  end

  def assoc_options
    @options ||= {}
  end
end

class SQLObject
  extend Associatable
end
