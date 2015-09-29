require_relative '03_associatable'

module Associatable

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.assoc_options[through_name]
      source_options = through_options.model_class.assoc_options[source_name]

      source_key = source_options.send(:foreign_key)
      through_key = through_options.send(:foreign_key)

      p source_key
      p through_key

      through_klass = through_options.model_class
      target_klass = source_options.model_class

      p through_klass
      p target_klass

      results = DBConnection.execute(<<-SQL, self.send("#{through_key}"))
        SELECT
          *
        FROM
          #{through_klass.table_name}
        JOIN
          #{target_klass.table_name}
        ON
          #{through_klass.table_name}.#{source_key} = #{target_klass.table_name}.id
        WHERE
          #{through_klass.table_name}.id = ?
      SQL
      p results
    p results.map {|result| target_klass.new(result)}.first
    end
  end
end
