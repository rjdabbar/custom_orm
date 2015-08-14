require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns

    table = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
     table.first.map(&:to_sym)
  end

  def self.finalize!
    columns.each do |column|

      define_method(column) do
        attributes[column]
      end

      setter = column.to_s + "="

      define_method(setter) do |arg|
        attributes[column] = arg
      end

    end
  end

  def self.table_name=(table_name)
    self.instance_variable_set(:@table_name, table_name)
    # ...
  end

  def self.table_name

    if self.instance_variable_get(:@table_name).nil?
      self.table_name = self.to_s.tableize
    end
    self.instance_variable_get(:@table_name)
    # ...
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    @attributes ||= {}

    # @attributes
    # ...
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
