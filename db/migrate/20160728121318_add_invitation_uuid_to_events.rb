class AddInvitationUuidToEvents < ActiveRecord::Migration
  def change
    add_column :events, :invitation_uuid, :uuid
  end
end
