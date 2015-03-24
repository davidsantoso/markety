module Markety
  module Command
    module SyncCustomObject
      def sync_custom_objects(custom_object, sync_method)
        send_request(:sync_custom_objects,
          {
            "objTypeName" => custom_object.object_type_name,
            "operation" => "UPSERT",
            "customObjList" => custom_object.to_sync_custom_object_hash
          }
        )
      end
    end
  end
end
