module Markety
  module Command
    module SyncCustomObject
      def sync_custom_object(custom_object, operation="UPSERT")
        send_request(:sync_custom_objects,
          {
            "objTypeName" => custom_object.object_type_name,
            "operation" => operation,
            "customObjList" => custom_object.to_sync_custom_object_hash
          }
        )
      end
    end
  end
end
