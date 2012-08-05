module SimpleRecord
  class ResultsArray
    def ==(other)
      case other
      when nil then false
      when Array then self.to_a == other
      else self == other
      end
    end
  end
end

module SimpleRecord
  class Base
    extend OrmAdapter::ToAdapter

    def ==(other)
      return false if other.nil?
      attributes == other.attributes
    end

    def to_key
      key = self.id
      [key] if key
    end
    
    class OrmAdapter < ::OrmAdapter::Base
      # get a list of column names for a given class
      def column_names
        klass.defined_attributes.keys
      end

      # @see OrmAdapter::Base#get!
      def get!(id)
        klass.find(wrap_key(id))
      end

      # @see OrmAdapter::Base#get
      def get(id)
        klass.find(:first, :id => wrap_key(id))
      end

      # @see OrmAdapter::Base#find_first
      def find_first(options = {})
        conditions, order = extract_conditions!(options)
        params = { :conditions => conditions_to_array(conditions_to_fields(conditions)) }
        params[:order] = order_clause(order) unless order && order.empty?
        klass.find(:first, params)
      end

      # @see OrmAdapter::Base#find_all
      def find_all(options = {})
        conditions, order, limit, offset = extract_conditions!(options)
        params = { :conditions => conditions_to_array(conditions_to_fields(conditions)) }
        params[:order] = order_clause(order) unless order && order.empty?
        params[:limit] = limit unless limit.nil?
        klass.find(:all, params)
      end

      # @see OrmAdapter::Base#create!
      def create!(attributes = {})
        raise SimpleRecordError.new if attributes.keys.find{|k| !self.column_names.include?(k) }
        klass.create! attributes
      end

      # @see OrmAdapter::Base#destroy
      def destroy(object)
        object.destroy && object if valid_object?(object)
      end

    protected

      def conditions_to_array(conditions)
        case conditions
        when Hash
          values = []
          [ conditions.map{|k,v| values << v; "#{k} = ?"}.join(" AND ") ] + values
        else
          conditions
        end
      end

      def conditions_to_fields(conditions)
        conditions.inject({}) do |fields, (key, value)|
          if value.is_a?(SimpleRecord::Base) && klass.defined_attributes.keys.include?(key)
            fields.merge("#{key}_id" => value.id)
          else
            fields.merge(key => value)
          end
        end
      end

      def order_clause(order)
        order.map {|pair| "#{pair[0]} #{pair[1]}"}.join(",")
      end
    end
  end
end
