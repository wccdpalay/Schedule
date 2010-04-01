module DbCharmer
  module MultiDbMigrations
    @multi_db_names = nil

    def migrate_with_db_wrapper(direction)
      @multi_db_names.each { |multi_db_name| on_db(multi_db_name) { migrate_without_db_wrapper(direction) } }
    end

    def on_db(db_name)
      announce "Switching connection to #{db_name}"
      old_proxy = ActiveRecord::Base.db_charmer_connection_proxy
      ActiveRecord::Base.switch_connection_to(db_name, DbCharmer.migration_connections_should_exist?)
      yield
    ensure
      announce "Checking all database connections"
      ActiveRecord::Base.verify_active_connections!
      announce "Switching connection back to default"
      ActiveRecord::Base.switch_connection_to(old_proxy)
    end

    def db_magic(opts = {})
      opts[:connection] = opts[:connections] if opts[:connections]
      raise ArgumentError, "No connection name - no magic!" unless opts[:connection]
      @multi_db_names = [opts[:connection]].flatten
      class << self
        alias_method_chain :migrate, :db_wrapper
      end
    end
  end
end
