module Levelup
  module Templates
    # A series of methods used to convert objects to/from hashes.
    class DataParcel
      def initialize(hash = {})
        assign_instance_variables_from_hash hash
      end

      # Determines if the specified instance variable is excluded from this
      # object's generated hash.
      def self.excluded?(instance_variable)
        instance_variables_excluded_from_hash.include? instance_variable
      end

      def self.instance_variables_excluded_from_hash
        [:excluded_from_hash]
      end

      private

      # hash: A hash mapping instance variable names to their desired values
      def assign_instance_variables_from_hash(hash)
        hash.each { |key, value| public_send("#{key}=", value) }
      end

      def to_hash
        body = {}

        instance_variables.each do |variable|
          instance_variable_name = variable.to_s.delete('@').to_sym

          unless self.class.excluded?(instance_variable_name)
            body[instance_variable_name] = instance_variable_get(variable)
          end
        end

        body
      end
    end
  end
end
