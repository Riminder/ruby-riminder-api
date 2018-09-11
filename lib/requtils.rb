require 'active_support'
require 'active_support/core_ext'

require_relative 'riminderException.rb'



class ReqUtils
    def self.add_if_not_blank(to_fill, key, elem)
        if (!elem.nil? && !elem.blank?)
            to_fill[key] = elem
        end
        return to_fill
    end

    def self.assertIDRef(prefix, options)
        ref = prefix + '_id'
        id = prefix + '_reference'
        if (!options.key?(ref) && !options.key?(id))
            raise RiminderArgumentException("'%s' or '%s' should exist in options"[ref, id])
        end
    end

    def self.validateTrainingMetadata(to_validate)
        if (to_validate.kind_of?(NilClass) || to_validate.nil?)
            return to_validate
        end
        # True if have to be filled els otherwise
        mandatory_keys = {'filter_reference' => true, 'stage' => false, 'stage_timestamp' => false, 'rating' => false, 'rating_timestamp' => false}
        if (!to_validate.kind_of?(Array))
            raise RiminderArgumentException.new('Training metadatas should be an array.')
        end
        mandatory_keys.each_pair{|key, shouldbefilled|
            to_validate.each {|to_validate_elem|
                if (!to_validate_elem.key?(key))
                    raise RiminderArgumentException.new('All training metadata should contain %s' [key])
                end
                if (shouldbefilled && to_validate_elem[key].blank?)
                    raise RiminderArgumentException.new('All training metadata should contain %s not nil or empty' [key])
                end

            }
        }
        return to_validate
    end
end