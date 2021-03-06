module DbCharmer
  module AssociationPreload
    module ClassMethods
      ASSOCIATION_TYPES = [ :has_one, :has_many, :belongs_to, :has_and_belongs_to_many ]
      ASSOCIATION_TYPES.each do |association_type|
        class_eval <<-EOF, __FILE__, __LINE__ + 1
          def preload_#{association_type}_association(records, reflection, preload_options = {})
            return super(records, reflection, preload_options) if self.db_charmer_top_level_connection?
            reflection.klass.on_db(self) do
              super(records, reflection, preload_options)
            end
          end
        EOF
      end
    end
  end
end
