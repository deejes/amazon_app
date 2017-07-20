class RenamePasswordCluster < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :password_cluster, :password_digest
  end
end
