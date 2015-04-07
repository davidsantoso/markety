module Markety
  module Command
    module SyncCustomObject
      def sync_custom_object(custom_object, operation="UPSERT")
        sync_custom_objects_request(custom_object.object_type_name, operation, custom_object.to_sync_custom_object_hash)
      end

      def sync_custom_objects(custom_objects, operation="UPSERT")
        object_type_name = custom_objects.first.object_type_name
        sync_custom_objects_request(object_type_name, operation, multiple_custom_obj_params(custom_objects))
      end

      private

      def multiple_custom_obj_params(custom_objects)
        custom_objects.map{|custom_object| custom_object.to_sync_custom_object_hash}
      end

      def sync_custom_objects_request(object_type_name, operation, custom_obj_list)
        send_request(:sync_custom_objects,
          {
            "objTypeName" => object_type_name,
            "operation" => operation,
            "customObjList" => {
              "customObj" => custom_obj_list
            }
          }
        )
      end
    end
  end
end
