require "action_dispatch"

module ActionDispatch
  module Session
    class CustomizedActiveRecordStore < ActiveRecordStore
      private

      def set_session(env, sid, session_data, options)
        user_id = session_data["warden.user.user.key"].try(:first).try(:first)

        ActiveRecord::Base.logger.quietly do
          record = get_session_model(env, sid)
          record.user_id = user_id
          record.data = session_data
          return false unless record.save

          session_data = record.data
          if session_data && session_data.respond_to?(:each_value)
            session_data.each_value do |obj|
              obj.clear_association_cache if obj.respond_to?(:clear_association_cache)
            end
          end
        end

        sid
      end
    end
  end
end
